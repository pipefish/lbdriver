require "protobuf"
require "lbdriver"
require "lbdriver/adminapi"
require "lbdriver/commandapi"
require "lbdriver/configuration"
require "lbdriver/connection"
require "blox/connect/ConnectBlox.pb"
require "test/unit"

class LBDriverAPITest < Test::Unit::TestCase

    def checkResults(results) 
        puts "in checkResults results is " + results.inspect + "\n"
        assert_equal(results[0][0][:value], '1')
        assert_equal(results[0][1][:value], '150000')
        assert_equal(results[0][2][:value], 1.5)
        assert_equal(results[0][3][:value], "Zef")
        assert_equal(results[0][4][:value], true)
        assert_equal(results[1][0][:value], '2')
        assert_equal(results[1][1][:value], '250000')
        assert_equal(results[1][2][:value], 2.5)
        assert_equal(results[1][3][:value], "Zef2")
        assert_equal(results[1][4][:value], false)
    end
 
  def test_apitest
    puts "Testing LogicBlox Driver API\n"
    workspace = "testspace"
    adminChannel = nil
    commandChannel = nil



    LBDriver.configuration({
                                    :options => {   "logger"        => Logger.new(STDOUT),
                                                    "adminhost"     => "glmaster.pipefish.com",
                                                    "adminport"     => 55181,
                                                    "commandhost"   => "glmaster.pipefish.com",
                                                    "commandport"   => 55179}
                                })


    LBDriver.configuration.logger.info("Driver created with configuration: " + LBDriver.configuration.inspect)

    puts "Creating admin channel\n"
    adminChannel = LBDriver.getAdminAPI
    puts "Creating command channel\n"
    commandChannel = LBDriver.getCommandAPI

    puts "Cleaning up from any previous failed tests\n"


    workspaces = adminChannel.listWorkspaces()
    workspaces.each { |ws| 
        puts "Attempting to remove workspace: '#{ws}'\n"
        commandChannel.removeWorkspace(ws)
    }


    puts "Creating workspace\n"
    commandChannel.createWorkspace(workspace)


    puts "Creating anonymous workspace\n"
    result =  commandChannel.createWorkspace()
    assert_equal(result.name.is_a?(String), true, "Workspace creation returned a workspace name")
    puts "anonymous workspace result is " + result.inspect + "\n"

    puts "Current workspaces: "
    workspaces = adminChannel.listWorkspaces()
    workspaces.each { |ws| 
        puts "'#{ws}',"
    }
    puts "\n"

    puts "Adding block\n"
    result = commandChannel.addBlock(workspace, {
        :name =>"myblock",
        :inactive => false,
        :logic => "p(a, b, c, d, e, f) -> int(a), decimal(b), float(c), string(d), boolean(e), datetime(f)."
    })
    assert_equal(result, "myblock")

    puts "Inspecting resulting predicate\n"
    predicates = commandChannel.listPredicates(workspace)
    assert_equal(predicates.length, 1, "number of defined predicates")
    predInfo = commandChannel.predInfo(workspace, "p")
    assert_equal(predInfo.name, "p")

    puts "Inserting some data\n"
    commandChannel.exec(workspace, {
        :logic => '+p(1, 1.5d, 1.5f, "Zef", true, datetime:now[]).'
    })
    puts "Inserting some more data\n"
    commandChannel.exec(workspace, {
        :logic => '+p(?, ?d, ?f, ?, ?, datetime:now[]).',
        :args => [2, 2.5, 2.5, "Zef2", true]
    })
    puts "Inserting this last little bit of data\n"
    commandChannel.exec(workspace, {
        :logic =>'+p(2, 2.5d, 2.5f, "Zef2", false, datetime:now[]).'
    })

 
    puts "Getting the results back and verifying them\n"
    results = commandChannel.queryPredicate(workspace, "p")
    checkResults(results)
    puts "Executing a query\n"
    results = commandChannel.query(workspace, {
        :logic => '_(a, b, c, d, e, f) <- p(a, b, c, d, e, f).'
    })
    puts "And verifying the results\n"
    checkResults(results)

    puts "Exporting and importing workspace\n"
    commandChannel.exportWorkspace(workspace, "/tmp/lbdb")
    commandChannel.importWorkspace("lbtest2", "/tmp/lbdb")
    puts "Verifying the imported workspace is the same as the original\n"
    predicates = commandChannel.listPredicates("lbtest2")
    assert_equal(predicates.length, 1)
    assert_equal(predicates[0].name, "p")
    commandChannel.removeWorkspace("lbtest2")
    puts "closing the channels\n"
    commandChannel.close()
    adminChannel.close()

  end
 
end
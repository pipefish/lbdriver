lbdriver - A Ruby driver for LogicBlox databases
========

This gem is based significantly on Zef Hemel's [node-lbc](https://bitbucket.org/logicblox/node-lbc) Node.js client. Most of what is here would not exist without Zef's help. This gem uses connection_pool and Celluloid gems to provide connection pooling and more efficient async network layers. 

[LogicBlox](http://logicblox.com) is a NoSQL database that uses a language called LogiQL. LogiQL is based on Datalog which is a data oriented version of Prolog. 

The goal with this gem is to provide low level direct access to the database but to also provide a connected graph oriented API similar to what Neo4J has done. The idea is to do for graphs what ActiveRecord does for relational databases. 

Here's the basic usage:

```ruby
	LBDriver.configuration({
                                    :options => {   "logger"        => Logger.new(STDOUT),
                                                    "adminhost"     => "myhost.example.com",
                                                    "adminport"     => 55181,
                                                    "commandhost"   => "myhost.example.com",
                                                    "commandport"   => 55179}
                                })


    LBDriver.configuration.logger.info("Driver created with configuration: " + LBDriver.configuration.inspect)

    # Create the admin and command channels
    adminChannel = LBDriver.getAdminAPI
    commandChannel = LBDriver.getCommandAPI

   
	# create a workspace
    commandChannel.createWorkspace("MyDatabase")

    # add a block
    result = commandChannel.addBlock("MyDatabase", {
        :name =>"myblock",
        :inactive => false,
        :logic => "p(a, b, c, d, e, f) -> int(a), decimal(b), float(c), string(d), boolean(e), datetime(f)."
    })

	# insert some data
    commandChannel.exec(workspace, {
        :logic => '+p(1, 1.5d, 1.5f, "Foo", true, datetime:now[]).'
    })
    
    # execute a query
    results = commandChannel.queryPredicate(workspace, "p")
	
	commandChannel.close()
    adminChannel.close()

```
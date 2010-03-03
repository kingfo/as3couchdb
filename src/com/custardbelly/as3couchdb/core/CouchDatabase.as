/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: CouchDatabase.as</p>
 * <p>Version: 0.1</p>
 *
 * <p>Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:</p>
 *
 * <p>The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.</p>
 *
 * <p>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.</p>
 *
 * <p>Licensed under The MIT License</p>
 * <p>Redistributions of files must retain the above copyright notice.</p>
 */
package com.custardbelly.as3couchdb.core
{
	import com.custardbelly.as3couchdb.mediator.CouchDatabaseActionMediator;
	import com.custardbelly.as3couchdb.mediator.ICouchDatabaseActionMediator;
	import com.custardbelly.as3couchdb.service.CouchDatabaseService;
	
	/**
	 * Dispatched upon successful read in and application of attributes from a database instance in CouchDB. 
	 */
	[Event(name="read", type="com.custardbelly.as3couchdb.event.CouchEvent")]
	/**
	 * Dispatched upon successful creation and save of a database in CouchDB. 
	 */
	[Event(name="save", type="com.custardbelly.as3couchdb.event.CouchEvent")]
	/**
	 * Dispatched upon successful deletion of database in CouchDB. 
	 */
	[Event(name="delete", type="com.custardbelly.as3couchdb.event.CouchEvent")]
	
	/**
	 * <p>CouchDatabase is a base model representing an instance of a Couch Database. To effectively use a CouchDatabase and its methods,
	 * this class should be extended and metadata information annotated describing the base url and database name of the CouchDatabase instance and the 
	 * name of the database which this model represents.</p>
	 * 
	 * <example>
	 * [DocumentService(url="http://127.0.0.1:5984", name="contacts")]
	 * public class ContactsDatabase extends CouchDatabase
	 * {
	 * 	...
	 * }
	 * </example>
	 *  
	 * @author toddanderson
	 */	
	public class CouchDatabase extends CouchModel
	{
		public var db_name:String;
		public var doc_count:int;
		public var doc_del_count:int;
		public var update_seq:int;
		public var purge_seq:int;
		public var compact_running:Boolean;
		public var disk_size:Number;
		public var instance_start_time:Number;
		public var disk_format_version:int;
		
		/**
		 * @private
		 * 
		 * Service action mediator. 
		 */
		protected var _actionMediator:ICouchDatabaseActionMediator;
		
		/**
		 * Constructor. Resolves entity and creates ICouchDatabaseActionMediator to handle service actions.
		 */
		public function CouchDatabase()
		{
			super();
			db_name = databaseName;
			_actionMediator = new CouchDatabaseActionMediator( this, CouchDatabaseService.getDatabaseService( baseUrl ) );
		}
		
		/**
		 * Invokes action mediator to create database if not exists.
		 */
		public function createIfNotExist():void
		{
			_actionMediator.handleCreateIfNotExist();
		}
		
		/**
		 * Invokes action mediator to read in database information.
		 */
		public function read():void
		{
			_actionMediator.handleRead();
		}
		
		/**
		 * Invokes action mediator to delete database.
		 */
		public function remove():void
		{
			_actionMediator.handleDelete();
		}
		
		/**
		 * Invokes action mediator to request information about database.
		 */
		public function info():void
		{
			_actionMediator.handleInfo();
		}
		
		/**
		 * Invokes action mediator to request changes to database.
		 */
		public function getChanges():void
		{
			_actionMediator.handleGetChanges();	
		}
		
		/**
		 * Invokes action mediator to compact and optionally cleanup database. 
		 * @param cleanup Boolean
		 */
		public function compact( cleanup:Boolean = false ):void
		{
			_actionMediator.handleCompact( cleanup );
		}
	}
}
/**
 * Test Json utility
 *
 * @author dsrini.open
 **/
component displayname="testJson" extends="mxunit.framework.TestCase" accessors=true output=false persistent=false {

	public void function beforeTests() output="false" {
		json = CreateObject('component', 'json');

		testData = [
			{
				"id": 10,
				"title": "title1",
				"name": javaCast( "null", 0 ),
				"amt": 10.0521,
				"create_dt": createDateTime("2030","01","01"),
				"modify_dt": createDateTime("2030","02","01",12,0,10)
			},
			{
				"id": 11,
				"title": "title2",
				"name": "name2",
				"amt": 10.9921,
				"create_dt": createDateTime("2011","02","06"),
				"modify_dt": createDateTime("2011","02","07",05,25,36)
			}
		];
	}

	public void function testValidEncode() {
		var local = {
			verify = '{"query":{"columnlist":"AMT,CREATE_DT,ID,MODIFY_DT,NAME,TITLE","data":[{"create_dt":"January, 01 2030 00:00:00","modify_dt":"February, 01 2030 12:00:10","amt":10.0521,"title":"title1","id":10,"name":null},{"create_dt":"February, 06 2011 00:00:00","modify_dt":"February, 07 2011 05:25:36","amt":10.9921,"title":"title2","id":11,"name":"name2"}],"recordcount":2},"totalCount":2}'
		};

		local.testQry = queryNew(
			"id,title,name,amt,create_dt,modify_dt",
			"integer,varchar,varchar,double,date,timestamp",
			testData
		);

		local.text = json.encode(local.testQry);

		assertTrue(
			Compare(local.text, local.verify) eq 0,
			"Output matches");
	}

	public void function testValidEncodeCapitalize() {
		var local = {
			verify = '{"query":{"columnlist":"AMT,CREATE_DT,ID,MODIFY_DT,NAME,TITLE","data":[{"CREATE_DT":"January, 01 2030 00:00:00","MODIFY_DT":"February, 01 2030 12:00:10","AMT":10.0521,"TITLE":"title1","ID":10,"NAME":null},{"CREATE_DT":"February, 06 2011 00:00:00","MODIFY_DT":"February, 07 2011 05:25:36","AMT":10.9921,"TITLE":"title2","ID":11,"NAME":"name2"}],"recordcount":2},"totalCount":2}'
		};

		local.testQry = queryNew(
			"id,title,name,amt,create_dt,modify_dt",
			"integer,varchar,varchar,double,date,timestamp",
			testData
		);

		local.text = json.encode(local.testQry, true);

		assertTrue(
			Compare(local.text, local.verify) eq 0,
			"Output matches");
	}

	public void function testValidEncodeFieldsList() {
		var local = {
			verify = '{"query":{"columnlist":"ID,TITLE","data":[{"title":"title1","id":10},{"title":"title2","id":11}],"recordcount":2},"totalCount":2}'
		};

		local.testQry = queryNew(
			"id,title,name,amt,create_dt,modify_dt",
			"integer,varchar,varchar,double,date,timestamp",
			testData
		);

		local.text = json.encode(local.testQry, false, "id,title");

		assertTrue(
			Compare(local.text, local.verify) eq 0,
			"Output matches");
	}

	public void function testInValidEncodeFieldsList() {
		var local = {
			verify = '{"query":{"columnlist":"AMT,CREATE_DT,ID,MODIFY_DT,NAME,TITLE","data":[{"create_dt":"January, 01 2030 00:00:00","modify_dt":"February, 01 2030 12:00:10","amt":10.0521,"title":"title1","id":10,"name":null},{"create_dt":"February, 06 2011 00:00:00","modify_dt":"February, 07 2011 05:25:36","amt":10.9921,"title":"title2","id":11,"name":"name2"}],"recordcount":2},"totalCount":2}'
		};

		local.testQry = queryNew(
			"id,title,name,amt,create_dt,modify_dt",
			"integer,varchar,varchar,double,date,timestamp",
			testData
		);

		local.text = json.encode(local.testQry, false, "some,some2");

		assertTrue(
			Compare(local.text, local.verify) eq 0,
			"Output matches");
	}
}
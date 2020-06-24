/**
 * json serialization cfc component
 *
 * @author dsrini.open
 **/
component displayname="json" accessors=true output=false persistent=false {

	public string function encode(required query qryInput, boolean capitalize = false, string fieldsList = "") {
		var local = {
			qry = Arguments.qryInput
		};

		try{
			if(LEN(Arguments.fieldsList)) {
				local.qry = queryExecute("SELECT #Arguments.fieldsList# FROM [local].qry", {}, {dbtype= "query"});
			}
		} catch(any E) {
			WriteLog(file="error", text="Error executing filtering QOQ: #E.message#:#E.detail#");
		}

		local.retObj = {
			"query": {
				"columnlist": local.qry.columnList,
				"recordcount": local.qry.recordCount,
				"data":	Deserializejson(Serializejson(local.qry, "struct"))
			},
			"totalCount": local.qry.recordCount
		};
		
		/* Wish, adobe has correct way to handle this in future. 
		 * For now, metadata has to be with each struct in the array 
		 */
		if(!capitalize) {
			local.metadata = {};
			for(local.eachCol in ListToArray(local.retObj.query.columnlist))
				local.metadata[local.eachCol] = {name: Lcase(local.eachCol)};

			for(local.eachDataSt in local.retObj.query.data)
				local.eachDataSt.setMetadata(local.metadata);
		}

		return Serializejson(local.retObj, "struct");
	}
}
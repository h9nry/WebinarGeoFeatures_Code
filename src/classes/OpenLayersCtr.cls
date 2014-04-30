public with sharing class OpenLayersCtr {
	/** This property returns the main account */
	public Account mainAccount {
		get;
		set {
			this.mainAccount = [SELECT Id, 
									Name, 
									Location__Latitude__s, 
									Location__Longitude__s,
									(SELECT Id FROM Contacts) 
								FROM Account
								WHERE Id = :value.Id];
		}
	}
	
	/** This property returns the main account as JSON string */
	public String mainAccountJSON {
		get {
			return JSON.serialize(this.mainAccount);
		}
		set;
	}
	
	/** This property returns all nearby account */
	public List<Account> nearbyAccounts { 
		get {
			if (this.nearbyAccounts == null) {
				this.nearbyAccounts = Database.query('SELECT Id, '+
														'Name, '+
														'Location__Latitude__s, '+
														'Location__Longitude__s, '+
														'(SELECT Id FROM Contacts) '+
													'FROM Account '+
													'WHERE Id != \''+this.mainAccount.Id+'\' '+
													'AND DISTANCE(Location__c, GEOLOCATION('+String.valueOf(this.mainAccount.Location__Latitude__s)+', '+
																							String.valueOf(this.mainAccount.Location__Longitude__s)+'), \'km\') < 100');
			}
			return this.nearbyAccounts;
		}
		set; 
	}
	
	/** This property returns all nearby accounts as JSON string */
	public String nearbyAccountsJSON {
		get {
			return JSON.serialize(this.nearbyAccounts);
		}
		set;
	}
	
	/** CONSTRUCTOR */
	public OpenLayersCtr(ApexPages.StandardController stdController) {
        this.mainAccount = (Account)stdController.getRecord();
    }
}
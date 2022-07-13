public inherited sharing class Search {
    @AuraEnabled(Cacheable = true)
    public static List<Account> findAccounts(String accName) {
        // accName = '%' + accName + '%';
        List<Account> accList = [SELECT Id, Name, (SELECT Opportunity.Name, Opportunity.CreatedDate, Opportunity.CloseDate, Opportunity.StageName, Opportunity.Amount FROM Account.Opportunities) FROM Account 
        WHERE Name=:accName];
        return accList; 
    }
}

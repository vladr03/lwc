public with sharing class getDataForTheThirdStep {
    @AuraEnabled(cacheable= true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Account.Name, (SELECT Opportunity.Id, Opportunity.Name, Opportunity.CreatedDate, Opportunity.CloseDate, Opportunity.StageName, Opportunity.Amount FROM Account.Opportunities) FROM Account];
    }

    @AuraEnabled(cacheable = true)
    public static List<Account> getAccount(String accId) {
        return [SELECT Id, Account.Name, (SELECT Opportunity.Id, Opportunity.Name, Opportunity.CreatedDate, Opportunity.CloseDate, Opportunity.StageName, Opportunity.Amount FROM Account.Opportunities) FROM Account WHERE Id = :accId];
    }

    @AuraEnabled(cacheable = true)
    public static List<OpportunityLineItem> getOppProd(String oppId) {
        List<OpportunityLineItem> oppProdList = [SELECT Id, Product2.Name, Quantity, TotalPrice FROM OpportunityLineItem WHERE OpportunityId = :oppId];
        return oppProdList;
    }
}
@isTest
public class getDataForTheThirdStepTest {
    
    @isTest
    static void testGetAccountList() {
        for (Integer i = 0; i < 3; i++) {
            Account acc = new Account(Name = 'TestCompany ' + i);
            insert acc; 
            Opportunity opp = new Opportunity();
            opp.AccountId = acc.Id;
            opp.Name = 'TestName';
        }
        List<Account> isSelected = getDataForTheThirdStep.getAccountList(); 
        System.assert(isSelected != null);
    }
    
    @isTest
    static void testGetAccount() {
        Account acc = new Account(Name = 'Company');
        insert acc;
        List<Account> isSelected = getDataForTheThirdStep.getAccount(acc.Id);
        System.assert(isSelected != null);
    }
    
    @isTest
    static void testGetOppProd(){
        Id priceBookId = Test.getStandardPricebookId();
        Product2 prod = new Product2(
            Name = 'Product',
            ProductCode = 'R006E2',
            isActive = true);
        insert prod;
        
        PricebookEntry pbEntry = new PricebookEntry(
            Pricebook2Id = priceBookId,
            Product2Id = prod.Id,
            UnitPrice = 100.00,
            IsActive = true);
        insert pbEntry;
        Opportunity opp = new Opportunity();
        opp.Name = 'TestName';
        OpportunityLineItem olt = new OpportunityLineItem();
        olt.priceBookEntryId = priceBookId;
        olt.OpportunityId = opp.Id;
        olt.Quantity = 5;
        olt.TotalPrice = 50000;
        List<OpportunityLineItem> isSelected = getDataForTheThirdStep.getOppProd(opp.Id);
        System.assert(isSelected != null);
    }
}
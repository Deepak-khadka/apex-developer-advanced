@isTest
private class AddPrimaryContactTest {
    
    @isTest static void TestList() {
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<50; i++) {
            accounts.add(new Account(Name='Test Account ' + i, BillingState = 'CA'));
        }
        for(Integer j=0; j<50; j++) {
            accounts.add(new Account(Name='Test Account ' + j, BillingState = 'NY'));
        }

        insert accounts;

        Contact c = new Contact();
        c.FirstName = 'Test';
        c.LastName = 'Contact';

        insert c;

        String state = 'CA';

        AddPrimaryContact apc = new AddPrimaryContact(c, state);

        Test.startTest();
        System.enqueueJob(apc);
        Test.stopTest();
        
    }
}
@isTest
public class UpdateParentAccountTest {
   @TestSetup
   static void setup(){
    List<Account> accounts = new List<Account>();
    accounts.add(new Account(name='parent'));

    // add 100 child accounts
    for(Integer i=0;i<100;i++){
        accounts.add(new Account(name='Test Account'+i));
    }

    insert accounts;
   }

   static testmethod void testQueueable() {
    Id parentId = [SELECT Id FROM Account WHERE Name='parent'][0].Id;

    List<Account> accounts = [SELECT Id, name FROM Account WHERE name LIKE 'Test Account%'];

    UpdateContactAddresses updater = new UpdateContactAddresses(accounts, parentId);

    Test.startTest();
    System.enqueueJob(updater);
    Test.stopTest();

    // verify that the parent account was updated
    System.assertEquals(100, [SELECT count() FROM Account WHERE ParentId = :parentId]);
   }
}
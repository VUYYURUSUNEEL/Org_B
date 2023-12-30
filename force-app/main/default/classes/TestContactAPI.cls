@isTest
private class TestContactAPI {

    @isTest
    static void testHttpPost() {
        // Prepare mock request body
        List<ContactAPI.ConWrapper> mockWrappers = new List<ContactAPI.ConWrapper>();
        ContactAPI.ConWrapper wrapper = new ContactAPI.ConWrapper();
        wrapper.firstName = 'Test';
        wrapper.lastName = 'User';
        wrapper.emailCon = 'testuser@example.com';
        mockWrappers.add(wrapper);

        // Serialize mock request body
        String requestBody = JSON.serialize(mockWrappers);

        // Mock the request
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/ContactMapping/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(requestBody);
        RestContext.request = request;

        Test.startTest();
        Integer insertedContacts = ContactAPI.doPost();
        Test.stopTest();

        // Perform assertions based on the result of doPost() method
        System.assertEquals(1, insertedContacts, 'Expected 1 contact record to be inserted');
        // Add more assertions if needed
    }

    @isTest
    static void testHttpGet() {
        // Prepare test data - insert a contact record
        Contact testContact = new Contact(FirstName = 'John', LastName = 'Doe', Email = 'johndoe@example.com');
        insert testContact;

        Test.startTest();
        List<String> emailList = ContactAPI.geGet();
        Test.stopTest();

        // Perform assertions based on the result of geGet() method
        System.assertNotEquals(0, emailList.size(), 'Expected email list size should not be zero');
    }
}
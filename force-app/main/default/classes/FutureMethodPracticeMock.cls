public with sharing class FutureMethodPracticeMock implements HttpCalloutMock{

    public HTTPResponse respond(HTTPRequest req)
    {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody('{"status":"success"}');
        return res;
    }
}
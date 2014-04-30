public with sharing class BingGeoCoder {
	private static final String BING_LOCATIONS_URL = 'https://dev.virtualearth.net/REST/v1/Locations';
	
	// Please get your own API key at http://bingmapsportal.com/
	private static final String BING_KEY = 'YOURKEYGOESHERE';
	
	/**
	 * Performes a Bing Maps geocoding based upon the passed in input parameter.
	 */
	public static List<Double> geocode(String query){
		String param = EncodingUtil.urlEncode(query, 'UTF-8');
		
		// prepare request
		HTTP h = new HTTP();
		HTTPRequest req  = new HTTPRequest();
		req.setMethod('GET');
		
		String endpoint = BING_LOCATIONS_URL + '/' + param + '?key=' + BING_KEY;
		req.setEndpoint(endpoint);
		
		// fire request
		HTTPResponse res;
		try {
			res = h.send(req);
		} catch(CalloutException c){
			c.setMessage('Geocoding failed due to callout error: ' + c.getMessage());
			throw c;
		}
		
		// deserialize bing response
		BingQueryResponse bingResponse;
		try {
			bingResponse = (BingQueryResponse)JSON.deserialize(BingQueryResponse.fixJson(res.getBody()), BingQueryResponse.class);
		} catch(Exception e){
			e.setMessage('Geocoding failed due to deserialization error: ' + e.getMessage());
			throw e;
		}
		if (! bingResponse.resourceSets.isEmpty() 
			&& ! bingResponse.resourceSets[0].resources.isEmpty()
			&& ! bingResponse.resourceSets[0].resources[0].geocodePoints.isEmpty()) {
			
			return bingResponse.resourceSets[0].resources[0].geocodePoints[0].coordinates;
		} else {
			return new List<Double>();
		}
	}
}

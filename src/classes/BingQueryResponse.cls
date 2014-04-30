public with sharing class BingQueryResponse {
	public static String fixJson(String jsonStr){
		jsonStr = jsonStr.replace('\"__', '\"');
		return jsonStr;
	}
	
	public String authenticationResultCode;
	public String brandLogoUri;
	public String copyright;
	public List<ResourceSets> resourceSets;
	public Integer statusCode;
	public String statusDescription;
	public String traceId;
	public List<String> errorDetails;
	
	public class Address {
		public String addressLine;
		public String adminDistrict;
		public String adminDistrict2;
		public String countryRegion;
		public String formattedAddress;
		public String locality;
		public String postalCode;
		public String countryRegionIso2;
	}

	public class ResourceSets {
		public Integer estimatedTotal;
		public List<Resources> resources;
	}

	public class Point {
		public String type;
		public List<Double> coordinates;
	}

	public class Resources {
		public String type;
		public List<Double> bbox;
		public String name;
		public Point point;
		public Address address;
		public String confidence;
		public String entityType;
		public List<GeocodePoints> geocodePoints;
		public List<String> matchCodes;
	}

	public class GeocodePoints {
		public String type;
		public List<Double> coordinates;
		public String calculationMethod;
		public List<String> usageTypes;
	}
}
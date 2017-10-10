package com.mind.ws;

import net.webservicex.GeoIP;
import net.webservicex.GeoIPService;
import net.webservicex.GeoIPServiceSoap;

public class IPLocationFinder {

	public static void main(String[] args) {

		if(args.length !=1) {
			System.out.println("You need to paas 1 IP addr.");
		} else {
			String ipAddress = args[0];
			GeoIPService gips = new GeoIPService();
			GeoIPServiceSoap gipsSoap = gips.getGeoIPServiceSoap();
			GeoIP gip = gipsSoap.getGeoIP(ipAddress);
			System.out.println(gip.getCountryName());
		}
	}

}

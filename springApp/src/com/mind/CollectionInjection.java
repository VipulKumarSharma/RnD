package com.mind;

import java.util.List;
import java.util.Map;
import java.util.Set;

public class CollectionInjection {

	List addressList;
	Set  addressSet;
	Map  addressMap;
	
	public List getAddressList() {
		System.out.println("List Elements :"  + addressList);
		return addressList;
	}
	public void setAddressList(List addressList) {
		this.addressList = addressList;
	}
	
	public Set getAddressSet() {
		System.out.println("Set Elements :"  + addressSet);
		return addressSet;
	}
	public void setAddressSet(Set addressSet) {
		this.addressSet = addressSet;
	}
	
	public Map getAddressMap() {
		System.out.println("Map Elements :"  + addressMap);
		return addressMap;
	}
	public void setAddressMap(Map addressMap) {
		this.addressMap = addressMap;
	}
}

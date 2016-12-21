package aspects;

import healthwatcher.data.IAddressRepository;

public aspect Warning {
	declare error: 
		execution(* IAddressRepository+.*(..)) && !within(healthwatcher.data.rdb.AddressRepositoryRDB):
			"AddressRepositoryRDB type can only implement IAddressRepository";
}
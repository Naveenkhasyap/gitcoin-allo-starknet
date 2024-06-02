use starknet::{ContractAddress, get_caller_address, get_contract_address, contract_address_const};

// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⢿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⡟⠘⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣾⣿⣿⣿⣿⣾⠻⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⡿⠀⠀⠸⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⠀⠀⢀⣠⣴⣴⣶⣶⣶⣦⣦⣀⡀⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⡿⠃⠀⠙⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⠁⠀⠀⠀⢻⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠘⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⠃⠀⠀⠀⠀⠈⢿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⣰⣿⣿⣿⡿⠋⠁⠀⠀⠈⠘⠹⣿⣿⣿⣿⣆⠀⠀⠀
// ⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⢰⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⡀⠀⠀
// ⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣟⠀⡀⢀⠀⡀⢀⠀⡀⢈⢿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⡇⠀⠀
// ⠀⠀⣠⣿⣿⣿⣿⣿⣿⡿⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⡿⢿⠿⠿⠿⠿⠿⠿⠿⠿⠿⢿⣿⣿⣿⣷⡀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠸⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⠂⠀⠀
// ⠀⠀⠙⠛⠿⠻⠻⠛⠉⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣧⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⢻⣿⣿⣿⣷⣀⢀⠀⠀⠀⡀⣰⣾⣿⣿⣿⠏⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣧⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⠹⢿⣿⣿⣿⣿⣾⣾⣷⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠙⠋⠛⠙⠋⠛⠙⠋⠛⠙⠋⠃⠀⠀⠀⠀⠀⠀⠀⠀⠠⠿⠻⠟⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠟⠿⠟⠿⠆⠀⠸⠿⠿⠟⠯⠀⠀⠀⠸⠿⠿⠿⠏⠀⠀⠀⠀⠀⠈⠉⠻⠻⡿⣿⢿⡿⡿⠿⠛⠁⠀⠀⠀⠀⠀⠀
//                    allo.gitcoin.co

/// Registry contract
/// Solidity equivalent: https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/Registry.sol

/// Registry contract interface
/// Interface for the Registry contract.
#[starknet::interface]
pub trait IRegistry<TContractState> {
    fn is_member_of_profile(self: @TContractState, _profileID: u256, _member: ContractAddress) -> bool;
}

#[starknet::contract]
pub mod Registry {
    use starknet::ContractAddress;
    use allo::core::libraries::errors::Errors;
    use core::hash::{HashStateTrait,HashStateExTrait};
    use core::poseidon::PoseidonTrait;
    use openzeppelin::introspection::src5::SRC5Component;
    use openzeppelin::access::accesscontrol::AccessControlComponent;

    // ==========================
    // ======= Components =======
    // ==========================
    // This is dependency for AccessControlComponent
    component!(path: SRC5Component, storage: SRC5_supported_interfaces, event: SRC5ComponentEvent);
    #[abi(embed_v0)]
    impl SRC5Impl = SRC5Component::SRC5Impl<ContractState>;

    component!(path: AccessControlComponent, storage: accessControl, event: AccessControlComponentEvent);
    #[abi(embed_v0)]
    impl AccessControlComponentImpl = AccessControlComponent::AccessControlImpl<ContractState>;
    impl AccessControlComponentInternalImpl = AccessControlComponent::InternalImpl<ContractState>;
    
    // ==========================
    // === Storage Variables ====
    // ==========================
    #[storage]
    struct Storage {
        #[substorage(v0)]
        SRC5_supported_interfaces: SRC5Component::Storage,
        #[substorage(v0)]
        accessControl: AccessControlComponent::Storage,
    }

    /// ======================
    /// ======= Events =======
    /// ======================
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        AccessControlComponentEvent: AccessControlComponent::Event,
        #[flat]
        SRC5ComponentEvent: SRC5Component::Event,
    }


    #[constructor]
    fn constructor(ref self: ContractState,_owner: ContractAddress) { // Issue no #19
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L78C40-L79C9
    // Implement the functionality of making sure the address is not zero and
    // grant the Allo owner role to the owner.
    // You can use the posiedon hashing for hasing storing Allo owner
    self.accessControl.initializer();
    self.accessControl._grant_role(
        PoseidonTrait::new().update_with('ALLO_OWNER').finalize(),
         _owner
    );
    }


    /// ====================================
    /// ==== External/Public Functions =====
    /// ====================================
    #[abi(embed_v0)]
    impl Registry of super::IRegistry<
        ContractState
    > { // Issue no. #15 Implement the functionality to retrieve profile by profileId
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L94
    // Use _profileID as u256 

    // Issue no. #14 Implement the functionality to retrieve profile by anchor
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L102

    // Issue no. #13 Implement the functionality of createProfile
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L118C5-L125C18

    // Issue no. #12 Implement the functionality of updateProfileName
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L182C14-L182C31

    // Issue no. #11 Implement the functionality of updateProfileMetadata
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L214C14-L214C35

    // Issue no. #10 Implement the functionality of isOwnerOrMemberOfProfile
    // Use u256 instead of bytes32
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L229

    // Issue no. #3 Implement the functionality of isOwnerOfProfile
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L245

    // Issue no. #5 Implement the functionality of isMemberOfProfile
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L245
    fn is_member_of_profile(self: @ContractState, _profileID: u256, _member: ContractAddress) ->  bool {
        self._is_member_of_profile(_profileID, _member)
    }
    // Issue no. #9 Implement the functionality of UpdateProfilePendingOwner
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L253

    // Issue no. #8 Implement the functionality of acceptProfileOwnership
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L267

    // Issue no. #7 Implement the functionality of addMembers
    // Use u256 instead of bytes32
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L289

    // Issue no. #6 Implement the functionality of removeMembers
    // Use u256 instead of bytes32
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L311

    // Issue no. #16 Implement the functionality of recoverFunds
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L392C14-L392C26

    }

    /// ====================================
    /// ==== Internal Functions ============
    /// ====================================
    #[generate_trait]
    impl RegistryInternalImpl of RegistryInternalTrait { // Issue no. #19 Implement the functionality of _generateProfileId
    // Internal function to create a profile
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L366
    // Reference on how to implement keccak256(abi.encodePacked) 
    // Solidity - https://github.com/celestiaorg/blobstream-contracts/blob/0b4bcf69d1ce96df000da7f95fba8c03aa15a45e/src/lib/tree/namespace/TreeHasher.sol#L33
    // Cairo - https://github.com/keep-starknet-strange/blobstream-starknet/blob/b74777e5fb479e5b4aa5a1419135e0826343fc37/src/tree/namespace/hasher.cairo#L10
    // More about it - https://github.com/keep-starknet-strange/alexandria/tree/main/src/encoding

    // Issue no. #18 Implement the functionality of _generateAnchor
    // Internal function to create a _generateAnchor
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L340

    // Issue no. #17 Implement the functionality of _checkOnlyProfileOwner
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L331

    // Issue no. #4 Implement the functionality of _generateProfileId
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L375C14-L375C31

    // Issue no. #3 Implement the functionality of _isOwnerOfProfile
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L375C14-L375C31

    // Issue n. #5 Implement the functionality of _isMemberOfProfile
    // Down below is the function that is to be implemented in the contract but in cairo.
    // https://github.com/allo-protocol/allo-v2/blob/4dd0ea34a504a16ac90e80f49a5570b8be9b30e9/contracts/core/Registry.sol#L384C14-L384C32
    fn _is_member_of_profile(self: @ContractState, _profileID: u256, _member: ContractAddress) ->  bool {
        let role: felt252 =_profileID.try_into().unwrap();
        self.has_role(role, _member)
    }
    }
}

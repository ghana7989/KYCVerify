// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract KYCVerification {
    struct Bank {
        string name;
        address bankAddress;
        bool isBanned;
        bool isKYCPermission;
    }
    struct Customer {
        string name;
        string data;
        bool isVerified;
    }

    address public admin;
    mapping(address => Bank) private _bankAddressToBankMap;
    mapping(address => Customer[]) private _bankToCustomersMap;
    mapping(address => bool) private _bankToIsBannedMap;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    modifier onlyAuthorized(address _add) {
        require(
            msg.sender == admin ||
                _bankAddressToBankMap[_add].bankAddress == _add,
            "Only admin or bank can call this function"
        );
        require(
            _bankAddressToBankMap[_add].isKYCPermission == true,
            "KYC permission is not granted"
        );
        require(!_bankAddressToBankMap[_add].isBanned, "Bank is banned");
        _;
    }

    function stringsEquals(string memory s1, string memory s2)
        internal
        pure
        returns (bool)
    {
        bytes memory b1 = bytes(s1);
        bytes memory b2 = bytes(s2);
        uint256 l1 = b1.length;
        if (l1 != b2.length) return false;
        for (uint256 i = 0; i < l1; i++) {
            if (b1[i] != b2[i]) return false;
        }
        return true;
    }

    // GETTERS
    function getAdmin() public view returns (address) {
        return admin;
    }

    function getBank(address _bankAddress) public view returns (Bank memory) {
        return _bankAddressToBankMap[_bankAddress];
    }

    function getBankCustomers(address _bankAddress)
        public
        view
        returns (Customer[] memory)
    {
        return _bankToCustomersMap[_bankAddress];
    }

    // Add new bank to Blockchain ledger
    function addBank(string memory _bankName, address _bankAddress)
        public
        onlyAdmin
    {
        Bank memory bank;
        bank.name = _bankName;
        bank.bankAddress = _bankAddress;
        bank.isBanned = false;
        bank.isKYCPermission = false;
        // updating the state
        _bankAddressToBankMap[_bankAddress] = bank;
    }

    function getBankKYCStatus(address _bankAddress) public view returns (bool) {
        return _bankAddressToBankMap[_bankAddress].isKYCPermission;
    }

    // Add New customer to the bank
    function addCustomer(
        address _bankAddress,
        string memory _customerName,
        string memory _customerData
    )
        public
        onlyAuthorized(_bankAddress == address(0) ? msg.sender : _bankAddress)
    {
        Customer memory customer;
        customer.name = _customerName;
        customer.data = _customerData;
        customer.isVerified = false;
        // updating the state
        _bankToCustomersMap[_bankAddress].push(customer);
    }

    // Check KYC status of existing bank customers
    function checkKYCStatus(string memory _custName)
        public
        view
        returns (bool)
    {
        for (uint256 i = 0; i < _bankToCustomersMap[msg.sender].length; i++) {
            if (
                stringsEquals(
                    _bankToCustomersMap[msg.sender][i].name,
                    _custName
                )
            ) {
                return _bankToCustomersMap[msg.sender][i].isVerified;
            }
        }
        return false;
    }

    // Perform the KYC of the customer and update the status
    function performKYC(string memory _custName, address _bankAddress)
        public
        onlyAuthorized(_bankAddress == address(0) ? msg.sender : _bankAddress)
    {
        address bankAddress = _bankAddress == address(0)
            ? msg.sender
            : _bankAddress;
        for (uint256 i = 0; i < _bankToCustomersMap[bankAddress].length; i++) {
            if (
                stringsEquals(
                    _bankToCustomersMap[bankAddress][i].name,
                    _custName
                )
            ) {
                _bankToCustomersMap[bankAddress][i].isVerified = true;
                return;
            }
        }
    }

    // block bank to add any new customer
    function blockBankToAddNewCustomer(address _add) public onlyAdmin {
        _bankAddressToBankMap[_add].isBanned = true;
    }

    // Block bank to do KYC of the customers
    function blockBankToDoKYC(address _add) public onlyAdmin {
        _bankAddressToBankMap[_add].isKYCPermission = false;
    }

    // Allow the bank to add new customers which was banned earlier
    function allowBankToAddNewCustomer(address _add) public onlyAdmin {
        _bankAddressToBankMap[_add].isBanned = false;
    }

    //  Allow the bank to perform customer KYC which was banned earlier
    function allowBankToDoKYC(address _add) public onlyAdmin {
        _bankAddressToBankMap[_add].isKYCPermission = true;
    }

    // View customer data
    function getCustomerData(string memory _custName)
        public
        view
        returns (string memory)
    {
        for (uint256 i = 0; i < _bankToCustomersMap[msg.sender].length; i++) {
            if (
                stringsEquals(
                    _bankToCustomersMap[msg.sender][i].name,
                    _custName
                )
            ) {
                return _bankToCustomersMap[msg.sender][i].data;
            }
        }
        return "";
    }
}

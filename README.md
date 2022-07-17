# project submission
https://goerli.etherscan.io/address/0x4487c58a8961230e38c597f31e9f5e6430fff04f

This repo is a project submission for IIT Kanpur Blockchain Course.

Features of the application:

     1. Add new bank to Blockchain ledger:

This function is used by the admin to add a new bank to the KYC Contract. This function can be called by admin only. This function takes the below input parameters:

bankName of string type: The name of the bank
address of address type: The unique Ethereum address of the bank

     2. Add New customer to the bank:

This function will add a customer to the customer list. This function takes the below input parameters:

custName of string type:  The name of the customer
custData of string type: Customer supporting data such as address and mobile number

     3. Check KYC status of existing bank customers:

This function is used to fetch customer KYC status from the smart contract. If true, then the customer is verified. This function takes the below input parameter:

custName of string type: The name of the customer for whom KYC is to be done
Output: Return the KYC status, either true or false.

     4. Perform the KYC of the customer and update the status:

This function is used to add the KYC request to the requests list. If a bank is in banned status then the bank won’t be allowed to add requests for any customer. This function takes the below input parameter:

custName of string type: The name of the customer for whom KYC is to be done

     5. Block bank to add any new customer:

This function can only be used by the admin to block any bank from adding any new customer. This function takes the below input parameter:

add of address type: The unique Ethereum address of the bank

     6. Block bank to do KYC of the customers:

This function can only be used by the admin to change the status of KYC permission of any of the banks at any point of time. This function takes the below input parameter:

add of address type: The unique Ethereum address of the bank

     7. Allow the bank to add new customers which was banned earlier:

This function can only be used by the admin to allow any bank to add any new customer. This function takes the below input parameter:

add of address type: The unique Ethereum address of the bank

     8. Allow the bank to perform customer KYC which was banned earlier:

This function can only be used by the admin to change the status of KYC Permission of any of the banks at any point of time. This function takes the below input parameter:

add of address type: Unique Ethereum address of the bank

     9. View customer data:

This function allows a bank to view details of a customer. This function takes the below input parameter:

custName of string type: The name of the customer

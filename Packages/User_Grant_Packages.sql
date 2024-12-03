--Access for InventoryManager
-- Grant access to the InventoryManager package
GRANT EXECUTE ON InventoryManager TO INVENTORY_MANAGER_USR;

-- Grant access to the UtilityPackage for shared logic
GRANT EXECUTE ON UtilityPackage TO INVENTORY_MANAGER_USR;

-- Grant SELECT and UPDATE access to Warehouse_Product table
GRANT SELECT, UPDATE ON Warehouse_Product TO INVENTORY_MANAGER_USR;

-- Grant SELECT access to Product table
GRANT SELECT ON Product TO INVENTORY_MANAGER_USR;

-- Grant SELECT on sequences used by InventoryManager
GRANT SELECT ON SEQ_ORDER_ID TO INVENTORY_MANAGER_USR;

-- Grant access to utility functions used in InventoryManager
GRANT EXECUTE ON ValidateUserAccess TO INVENTORY_MANAGER_USR;
GRANT EXECUTE ON GetCurrentStock TO INVENTORY_MANAGER_USR;
GRANT EXECUTE ON IsProductInWarehouse TO INVENTORY_MANAGER_USR;

--------------------------------------------------------------------------------

--Access for SalesManager
-- Grant access to the SalesManager package
GRANT EXECUTE ON SalesManager TO SALES_MANAGER_USR;

-- Grant access to the UtilityPackage for shared logic
GRANT EXECUTE ON UtilityPackage TO SALES_MANAGER_USR;

-- Grant SELECT, INSERT, and UPDATE access to Customer_Order table
GRANT SELECT, INSERT, UPDATE ON Customer_Order TO SALES_MANAGER_USR;

-- Grant SELECT, INSERT access to Order_Details table
GRANT SELECT, INSERT ON Order_Details TO SALES_MANAGER_USR;

-- Grant SELECT access to Product table
GRANT SELECT ON Product TO SALES_MANAGER_USR;

-- Grant SELECT on sequences used by SalesManager
GRANT SELECT ON SEQ_ORDER_ID TO SALES_MANAGER_USR;

-- Grant access to utility functions used in SalesManager
GRANT EXECUTE ON ValidateUserAccess TO SALES_MANAGER_USR;
GRANT EXECUTE ON CalculateOrderTotal TO SALES_MANAGER_USR;
GRANT EXECUTE ON FindWarehouseWithStock TO SALES_MANAGER_USR;

--------------------------------------------------------------------------------

--Access for SupplierManager
-- Grant access to the SupplierManager package
GRANT EXECUTE ON SupplierManager TO SUPPLIER_MANAGER_USR;

-- Grant access to the UtilityPackage for shared logic
GRANT EXECUTE ON UtilityPackage TO SUPPLIER_MANAGER_USR;

-- Grant SELECT access to Warehouse_Product table
GRANT SELECT ON Warehouse_Product TO SUPPLIER_MANAGER_USR;

-- Grant access to utility functions used in SupplierManager
GRANT EXECUTE ON ValidateUserAccess TO SUPPLIER_MANAGER_USR;
GRANT EXECUTE ON CheckStockStatus TO SUPPLIER_MANAGER_USR;

--------------------------------------------------------------------------------

--Access for InventoryUser
-- Grant access to the InventoryUser package
GRANT EXECUTE ON InventoryUser TO INVENTORY_USER_USR;

-- Grant access to the UtilityPackage for shared logic
GRANT EXECUTE ON UtilityPackage TO INVENTORY_USER_USR;

-- Grant SELECT access to Warehouse_Product table
GRANT SELECT ON Warehouse_Product TO INVENTORY_USER_USR;

-- Grant SELECT access to Product table
GRANT SELECT ON Product TO INVENTORY_USER_USR;

-- Grant SELECT on sequences used by InventoryUser
GRANT SELECT ON SEQ_ORDER_ID TO INVENTORY_USER_USR;

-- Grant access to utility functions used in InventoryUser
GRANT EXECUTE ON ValidateUserAccess TO INVENTORY_USER_USR;
GRANT EXECUTE ON CheckStockStatus TO INVENTORY_USER_USR;
GRANT EXECUTE ON GetCurrentStock TO INVENTORY_USER_USR;
GRANT EXECUTE ON IsProductInWarehouse TO INVENTORY_USER_USR;

--------------------------------------------------------------------------------

-- Grant execute privileges on all packages for package_user
GRANT EXECUTE ON InventoryManager TO package_user;
GRANT EXECUTE ON SalesManager TO package_user;
GRANT EXECUTE ON SupplierManager TO package_user;
GRANT EXECUTE ON InventoryUser TO package_user;
GRANT EXECUTE ON UtilityPackage TO package_user;
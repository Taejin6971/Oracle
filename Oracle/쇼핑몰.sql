CREATE TABLE "Members" (
	"MemberID"	INT		NULL,
	"FirstName"	VARCHAR2(50)		NULL,
	"LastName"	VARCHAR2(50)		NULL,
	"Email"	VARCHAR2(100)		NULL,
	"PhoneNumber"	VARCHAR2(20)		NULL
);

CREATE TABLE "Addresses" (
	"AddressID"	INT		NULL,
	"MemberID"	INT		NULL,
	"AddressLine1"	VARCHAR2(100)		NULL,
	"AddressLine2"	VARCHAR2(100)		NULL,
	"City"	VARCHAR2(50)		NULL,
	"ZipCode"	VARCHAR2(20)		NULL
);

CREATE TABLE "Products" (
	"ProductID"	INT		NOT NULL,
	"ProductName"	VARCHAR2(100)		NULL,
	"Price"	NUMBER(10,2)		NULL,
	"Description"	VARCHAR2(500)		NULL
);

CREATE TABLE "Orders" (
	"OrderID"	INT		NULL,
	"MemberID"	INT		NULL,
	"ProductID"	INT		NOT NULL,
	"OrderDate"	DATE		NULL,
	"Quantity"	INT		NULL
);

ALTER TABLE "Members" ADD CONSTRAINT "PK_MEMBERS" PRIMARY KEY (
	"MemberID"
);

ALTER TABLE "Addresses" ADD CONSTRAINT "PK_ADDRESSES" PRIMARY KEY (
	"AddressID",
	"MemberID"
);

ALTER TABLE "Products" ADD CONSTRAINT "PK_PRODUCTS" PRIMARY KEY (
	"ProductID"
);

ALTER TABLE "Orders" ADD CONSTRAINT "PK_ORDERS" PRIMARY KEY (
	"OrderID",
	"MemberID",
	"ProductID"
);

ALTER TABLE "Addresses" ADD CONSTRAINT "FK_Members_TO_Addresses_1" FOREIGN KEY (
	"MemberID"
)
REFERENCES "Members" (
	"MemberID"
);

ALTER TABLE "Orders" ADD CONSTRAINT "FK_Members_TO_Orders_1" FOREIGN KEY (
	"MemberID"
)
REFERENCES "Members" (
	"MemberID"
);

ALTER TABLE "Orders" ADD CONSTRAINT "FK_Products_TO_Orders_1" FOREIGN KEY (
	"ProductID"
)
REFERENCES "Products" (
	"ProductID"
);


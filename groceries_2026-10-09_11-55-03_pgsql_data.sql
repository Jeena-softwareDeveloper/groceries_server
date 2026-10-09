--
-- PostgreSQL database dump
--

\restrict XD93F9cCr2jynjqUqdJldf4NU0dee0Qa3PaNwJ9YQ30PDIh4dAhQ8vzWEVhfmb0

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public."Wishlist" DROP CONSTRAINT "Wishlist_productId_fkey";
ALTER TABLE ONLY public."Wishlist" DROP CONSTRAINT "Wishlist_customerId_fkey";
ALTER TABLE ONLY public."Wallet" DROP CONSTRAINT "Wallet_customerId_fkey";
ALTER TABLE ONLY public."WalletTransaction" DROP CONSTRAINT "WalletTransaction_walletId_fkey";
ALTER TABLE ONLY public."Vendor" DROP CONSTRAINT "Vendor_staffId_fkey";
ALTER TABLE ONLY public."Vendor" DROP CONSTRAINT "Vendor_districtId_fkey";
ALTER TABLE ONLY public."Vendor" DROP CONSTRAINT "Vendor_areaId_fkey";
ALTER TABLE ONLY public."VendorWallet" DROP CONSTRAINT "VendorWallet_vendorId_fkey";
ALTER TABLE ONLY public."VendorWalletTransaction" DROP CONSTRAINT "VendorWalletTransaction_vendorId_fkey";
ALTER TABLE ONLY public."VendorWalletTransaction" DROP CONSTRAINT "VendorWalletTransaction_settlementId_fkey";
ALTER TABLE ONLY public."VendorStaff" DROP CONSTRAINT "VendorStaff_vendorId_fkey";
ALTER TABLE ONLY public."VendorSettlement" DROP CONSTRAINT "VendorSettlement_vendorId_fkey";
ALTER TABLE ONLY public."VendorRequest" DROP CONSTRAINT "VendorRequest_staffId_fkey";
ALTER TABLE ONLY public."VendorRequest" DROP CONSTRAINT "VendorRequest_districtId_fkey";
ALTER TABLE ONLY public."VendorRequest" DROP CONSTRAINT "VendorRequest_customerId_fkey";
ALTER TABLE ONLY public."VendorRequest" DROP CONSTRAINT "VendorRequest_areaId_fkey";
ALTER TABLE ONLY public."SupportTicket" DROP CONSTRAINT "SupportTicket_customerId_fkey";
ALTER TABLE ONLY public."Staff" DROP CONSTRAINT "Staff_districtId_fkey";
ALTER TABLE ONLY public."Staff" DROP CONSTRAINT "Staff_areaId_fkey";
ALTER TABLE ONLY public."StaffAuditLog" DROP CONSTRAINT "StaffAuditLog_staffId_fkey";
ALTER TABLE ONLY public."SearchLog" DROP CONSTRAINT "SearchLog_customerId_fkey";
ALTER TABLE ONLY public."Review" DROP CONSTRAINT "Review_vendorId_fkey";
ALTER TABLE ONLY public."Review" DROP CONSTRAINT "Review_productId_fkey";
ALTER TABLE ONLY public."Review" DROP CONSTRAINT "Review_orderId_fkey";
ALTER TABLE ONLY public."Review" DROP CONSTRAINT "Review_customerId_fkey";
ALTER TABLE ONLY public."Product" DROP CONSTRAINT "Product_vendorId_fkey";
ALTER TABLE ONLY public."Product" DROP CONSTRAINT "Product_subCategoryId_fkey";
ALTER TABLE ONLY public."Product" DROP CONSTRAINT "Product_categoryId_fkey";
ALTER TABLE ONLY public."ProductImage" DROP CONSTRAINT "ProductImage_productId_fkey";
ALTER TABLE ONLY public."ProductApproval" DROP CONSTRAINT "ProductApproval_productId_fkey";
ALTER TABLE ONLY public."Payment" DROP CONSTRAINT "Payment_customerId_fkey";
ALTER TABLE ONLY public."Order" DROP CONSTRAINT "Order_vendorId_fkey";
ALTER TABLE ONLY public."Order" DROP CONSTRAINT "Order_settlementId_fkey";
ALTER TABLE ONLY public."Order" DROP CONSTRAINT "Order_paymentId_fkey";
ALTER TABLE ONLY public."Order" DROP CONSTRAINT "Order_customerId_fkey";
ALTER TABLE ONLY public."Order" DROP CONSTRAINT "Order_addressId_fkey";
ALTER TABLE ONLY public."OrderItem" DROP CONSTRAINT "OrderItem_productId_fkey";
ALTER TABLE ONLY public."OrderItem" DROP CONSTRAINT "OrderItem_orderId_fkey";
ALTER TABLE ONLY public."Offer" DROP CONSTRAINT "Offer_vendorId_fkey";
ALTER TABLE ONLY public."Offer" DROP CONSTRAINT "Offer_districtId_fkey";
ALTER TABLE ONLY public."Offer" DROP CONSTRAINT "Offer_categoryId_fkey";
ALTER TABLE ONLY public."Notification" DROP CONSTRAINT "Notification_vendorId_fkey";
ALTER TABLE ONLY public."Notification" DROP CONSTRAINT "Notification_customerId_fkey";
ALTER TABLE ONLY public."MicroBanner" DROP CONSTRAINT "MicroBanner_districtId_fkey";
ALTER TABLE ONLY public."Inventory" DROP CONSTRAINT "Inventory_productId_fkey";
ALTER TABLE ONLY public."DeviceLocation" DROP CONSTRAINT "DeviceLocation_customerId_fkey";
ALTER TABLE ONLY public."DeliveryChargeRule" DROP CONSTRAINT "DeliveryChargeRule_districtId_fkey";
ALTER TABLE ONLY public."Customer" DROP CONSTRAINT "Customer_staffId_fkey";
ALTER TABLE ONLY public."CustomerCoupon" DROP CONSTRAINT "CustomerCoupon_customerId_fkey";
ALTER TABLE ONLY public."CustomerCoupon" DROP CONSTRAINT "CustomerCoupon_couponId_fkey";
ALTER TABLE ONLY public."Coupon" DROP CONSTRAINT "Coupon_vendorId_fkey";
ALTER TABLE ONLY public."Coupon" DROP CONSTRAINT "Coupon_categoryId_fkey";
ALTER TABLE ONLY public."Category" DROP CONSTRAINT "Category_parentId_fkey";
ALTER TABLE ONLY public."CartItem" DROP CONSTRAINT "CartItem_vendorId_fkey";
ALTER TABLE ONLY public."CartItem" DROP CONSTRAINT "CartItem_productId_fkey";
ALTER TABLE ONLY public."CartItem" DROP CONSTRAINT "CartItem_customerId_fkey";
ALTER TABLE ONLY public."Banner" DROP CONSTRAINT "Banner_districtId_fkey";
ALTER TABLE ONLY public."Area" DROP CONSTRAINT "Area_districtId_fkey";
ALTER TABLE ONLY public."Address" DROP CONSTRAINT "Address_customerId_fkey";
DROP INDEX public."Wishlist_customerId_productId_key";
DROP INDEX public."Wishlist_customerId_idx";
DROP INDEX public."Wallet_customerId_key";
DROP INDEX public."WalletTransaction_walletId_idx";
DROP INDEX public."Vendor_status_idx";
DROP INDEX public."Vendor_slug_key";
DROP INDEX public."Vendor_email_key";
DROP INDEX public."Vendor_districtId_status_isOpen_idx";
DROP INDEX public."Vendor_districtId_idx";
DROP INDEX public."Vendor_customerId_key";
DROP INDEX public."Vendor_code_key";
DROP INDEX public."Vendor_areaId_idx";
DROP INDEX public."VendorWallet_vendorId_key";
DROP INDEX public."VendorWalletTransaction_vendorId_idx";
DROP INDEX public."VendorWalletTransaction_settlementId_idx";
DROP INDEX public."VendorWalletTransaction_createdAt_idx";
DROP INDEX public."VendorStaff_vendorId_idx";
DROP INDEX public."VendorStaff_email_key";
DROP INDEX public."VendorSettlement_vendorId_key";
DROP INDEX public."VendorSettlement_vendorId_idx";
DROP INDEX public."VendorSettlement_status_idx";
DROP INDEX public."VendorSettlement_settlementNo_key";
DROP INDEX public."VendorSettlement_createdAt_idx";
DROP INDEX public."VendorRequest_status_idx";
DROP INDEX public."VendorRequest_staffId_idx";
DROP INDEX public."VendorRequest_customerId_idx";
DROP INDEX public."SupportTicket_customerId_idx";
DROP INDEX public."SuperAdmin_email_key";
DROP INDEX public."StaticPage_slug_key";
DROP INDEX public."Staff_phone_key";
DROP INDEX public."Staff_districtId_idx";
DROP INDEX public."Staff_code_key";
DROP INDEX public."Staff_code_idx";
DROP INDEX public."Staff_areaId_idx";
DROP INDEX public."StaffAuditLog_staffId_idx";
DROP INDEX public."StaffAuditLog_createdAt_idx";
DROP INDEX public."StaffAuditLog_action_idx";
DROP INDEX public."SearchLog_query_idx";
DROP INDEX public."Review_vendorId_idx";
DROP INDEX public."Review_productId_idx";
DROP INDEX public."Review_customerId_idx";
DROP INDEX public."RefreshToken_userId_idx";
DROP INDEX public."RefreshToken_token_key";
DROP INDEX public."Product_vendorId_status_isActive_idx";
DROP INDEX public."Product_vendorId_slug_key";
DROP INDEX public."Product_vendorId_idx";
DROP INDEX public."Product_status_idx";
DROP INDEX public."Product_sku_idx";
DROP INDEX public."Product_categoryId_idx";
DROP INDEX public."ProductImage_productId_idx";
DROP INDEX public."ProductApproval_vendorId_idx";
DROP INDEX public."ProductApproval_status_idx";
DROP INDEX public."ProductApproval_productId_idx";
DROP INDEX public."Payment_reference_key";
DROP INDEX public."Payment_customerId_idx";
DROP INDEX public."OtpSession_phone_idx";
DROP INDEX public."Order_vendorId_idx";
DROP INDEX public."Order_status_idx";
DROP INDEX public."Order_settlementId_idx";
DROP INDEX public."Order_orderNumber_key";
DROP INDEX public."Order_customerId_idx";
DROP INDEX public."Order_createdAt_idx";
DROP INDEX public."OrderItem_orderId_idx";
DROP INDEX public."Notification_vendorId_idx";
DROP INDEX public."Notification_customerId_idx";
DROP INDEX public."MicroBanner_districtId_idx";
DROP INDEX public."Inventory_productId_key";
DROP INDEX public."District_code_key";
DROP INDEX public."DeviceLocation_deviceId_key";
DROP INDEX public."DeviceLocation_deviceId_idx";
DROP INDEX public."DeviceLocation_customerId_idx";
DROP INDEX public."DeliveryChargeRule_districtId_idx";
DROP INDEX public."Customer_staffId_idx";
DROP INDEX public."Customer_phone_key";
DROP INDEX public."Customer_email_key";
DROP INDEX public."CustomerCoupon_customerId_couponId_key";
DROP INDEX public."Coupon_code_key";
DROP INDEX public."Category_slug_key";
DROP INDEX public."CartItem_vendorId_idx";
DROP INDEX public."CartItem_customerId_productId_key";
DROP INDEX public."CartItem_customerId_idx";
DROP INDEX public."Banner_districtId_idx";
DROP INDEX public."AuditLog_entityType_entityId_idx";
DROP INDEX public."AuditLog_createdAt_idx";
DROP INDEX public."AuditLog_actorId_idx";
DROP INDEX public."AuditLog_action_idx";
DROP INDEX public."Area_districtId_idx";
DROP INDEX public."AppSetting_key_key";
DROP INDEX public."Address_customerId_idx";
ALTER TABLE ONLY public."Wishlist" DROP CONSTRAINT "Wishlist_pkey";
ALTER TABLE ONLY public."Wallet" DROP CONSTRAINT "Wallet_pkey";
ALTER TABLE ONLY public."WalletTransaction" DROP CONSTRAINT "WalletTransaction_pkey";
ALTER TABLE ONLY public."Vendor" DROP CONSTRAINT "Vendor_pkey";
ALTER TABLE ONLY public."VendorWallet" DROP CONSTRAINT "VendorWallet_pkey";
ALTER TABLE ONLY public."VendorWalletTransaction" DROP CONSTRAINT "VendorWalletTransaction_pkey";
ALTER TABLE ONLY public."VendorStaff" DROP CONSTRAINT "VendorStaff_pkey";
ALTER TABLE ONLY public."VendorSettlement" DROP CONSTRAINT "VendorSettlement_pkey";
ALTER TABLE ONLY public."VendorRequest" DROP CONSTRAINT "VendorRequest_pkey";
ALTER TABLE ONLY public."SupportTicket" DROP CONSTRAINT "SupportTicket_pkey";
ALTER TABLE ONLY public."SuperAdmin" DROP CONSTRAINT "SuperAdmin_pkey";
ALTER TABLE ONLY public."StaticPage" DROP CONSTRAINT "StaticPage_pkey";
ALTER TABLE ONLY public."Staff" DROP CONSTRAINT "Staff_pkey";
ALTER TABLE ONLY public."StaffAuditLog" DROP CONSTRAINT "StaffAuditLog_pkey";
ALTER TABLE ONLY public."SearchLog" DROP CONSTRAINT "SearchLog_pkey";
ALTER TABLE ONLY public."Review" DROP CONSTRAINT "Review_pkey";
ALTER TABLE ONLY public."RefreshToken" DROP CONSTRAINT "RefreshToken_pkey";
ALTER TABLE ONLY public."Product" DROP CONSTRAINT "Product_pkey";
ALTER TABLE ONLY public."ProductImage" DROP CONSTRAINT "ProductImage_pkey";
ALTER TABLE ONLY public."ProductApproval" DROP CONSTRAINT "ProductApproval_pkey";
ALTER TABLE ONLY public."Payment" DROP CONSTRAINT "Payment_pkey";
ALTER TABLE ONLY public."OtpSession" DROP CONSTRAINT "OtpSession_pkey";
ALTER TABLE ONLY public."Order" DROP CONSTRAINT "Order_pkey";
ALTER TABLE ONLY public."OrderItem" DROP CONSTRAINT "OrderItem_pkey";
ALTER TABLE ONLY public."Offer" DROP CONSTRAINT "Offer_pkey";
ALTER TABLE ONLY public."Notification" DROP CONSTRAINT "Notification_pkey";
ALTER TABLE ONLY public."MicroBanner" DROP CONSTRAINT "MicroBanner_pkey";
ALTER TABLE ONLY public."Inventory" DROP CONSTRAINT "Inventory_pkey";
ALTER TABLE ONLY public."District" DROP CONSTRAINT "District_pkey";
ALTER TABLE ONLY public."DeviceLocation" DROP CONSTRAINT "DeviceLocation_pkey";
ALTER TABLE ONLY public."DeliveryChargeRule" DROP CONSTRAINT "DeliveryChargeRule_pkey";
ALTER TABLE ONLY public."Customer" DROP CONSTRAINT "Customer_pkey";
ALTER TABLE ONLY public."CustomerCoupon" DROP CONSTRAINT "CustomerCoupon_pkey";
ALTER TABLE ONLY public."Coupon" DROP CONSTRAINT "Coupon_pkey";
ALTER TABLE ONLY public."Category" DROP CONSTRAINT "Category_pkey";
ALTER TABLE ONLY public."CartItem" DROP CONSTRAINT "CartItem_pkey";
ALTER TABLE ONLY public."Banner" DROP CONSTRAINT "Banner_pkey";
ALTER TABLE ONLY public."AuditLog" DROP CONSTRAINT "AuditLog_pkey";
ALTER TABLE ONLY public."Area" DROP CONSTRAINT "Area_pkey";
ALTER TABLE ONLY public."AppSetting" DROP CONSTRAINT "AppSetting_pkey";
ALTER TABLE ONLY public."Address" DROP CONSTRAINT "Address_pkey";
DROP TABLE public."Wishlist";
DROP TABLE public."WalletTransaction";
DROP TABLE public."Wallet";
DROP TABLE public."VendorWalletTransaction";
DROP TABLE public."VendorWallet";
DROP TABLE public."VendorStaff";
DROP TABLE public."VendorSettlement";
DROP TABLE public."VendorRequest";
DROP TABLE public."Vendor";
DROP TABLE public."SupportTicket";
DROP TABLE public."SuperAdmin";
DROP TABLE public."StaticPage";
DROP TABLE public."StaffAuditLog";
DROP TABLE public."Staff";
DROP TABLE public."SearchLog";
DROP TABLE public."Review";
DROP TABLE public."RefreshToken";
DROP TABLE public."ProductImage";
DROP TABLE public."ProductApproval";
DROP TABLE public."Product";
DROP TABLE public."Payment";
DROP TABLE public."OtpSession";
DROP TABLE public."OrderItem";
DROP TABLE public."Order";
DROP TABLE public."Offer";
DROP TABLE public."Notification";
DROP TABLE public."MicroBanner";
DROP TABLE public."Inventory";
DROP TABLE public."District";
DROP TABLE public."DeviceLocation";
DROP TABLE public."DeliveryChargeRule";
DROP TABLE public."CustomerCoupon";
DROP TABLE public."Customer";
DROP TABLE public."Coupon";
DROP TABLE public."Category";
DROP TABLE public."CartItem";
DROP TABLE public."Banner";
DROP TABLE public."AuditLog";
DROP TABLE public."Area";
DROP TABLE public."AppSetting";
DROP TABLE public."Address";
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Address; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Address" (
    id text NOT NULL,
    "customerId" text NOT NULL,
    label text DEFAULT 'Home'::text NOT NULL,
    line1 text NOT NULL,
    line2 text,
    city text NOT NULL,
    state text NOT NULL,
    pincode text NOT NULL,
    latitude double precision,
    longitude double precision,
    "isDefault" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Address" OWNER TO groceries;

--
-- Name: AppSetting; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."AppSetting" (
    id text NOT NULL,
    key text NOT NULL,
    value jsonb NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."AppSetting" OWNER TO groceries;

--
-- Name: Area; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Area" (
    id text NOT NULL,
    "districtId" text NOT NULL,
    name text NOT NULL,
    pincode text,
    latitude double precision,
    longitude double precision,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Area" OWNER TO groceries;

--
-- Name: AuditLog; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."AuditLog" (
    id text NOT NULL,
    "actorType" text NOT NULL,
    "actorId" text,
    "actorName" text,
    action text NOT NULL,
    "entityType" text NOT NULL,
    "entityId" text NOT NULL,
    details jsonb,
    "ipAddress" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."AuditLog" OWNER TO groceries;

--
-- Name: Banner; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Banner" (
    id text NOT NULL,
    "districtId" text,
    title text NOT NULL,
    "imageUrl" text NOT NULL,
    "videoUrl" text,
    type text DEFAULT 'IMAGE'::text NOT NULL,
    "row" integer DEFAULT 1 NOT NULL,
    "linkUrl" text,
    "themeColor" text,
    "themeColorEnd" text,
    "sortOrder" integer DEFAULT 0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "startsAt" timestamp(3) without time zone,
    "endsAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Banner" OWNER TO groceries;

--
-- Name: CartItem; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."CartItem" (
    id text NOT NULL,
    "customerId" text NOT NULL,
    "vendorId" text NOT NULL,
    "productId" text NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."CartItem" OWNER TO groceries;

--
-- Name: Category; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Category" (
    id text NOT NULL,
    "parentId" text,
    name text NOT NULL,
    slug text NOT NULL,
    "imageUrl" text,
    "sortOrder" integer DEFAULT 0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Category" OWNER TO groceries;

--
-- Name: Coupon; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Coupon" (
    id text NOT NULL,
    code text NOT NULL,
    description text,
    scope text NOT NULL,
    "vendorId" text,
    "categoryId" text,
    "discountPct" numeric(65,30),
    "discountAmt" numeric(65,30),
    "minOrder" numeric(65,30),
    "maxDiscount" numeric(65,30),
    "usageLimit" integer,
    "usedCount" integer DEFAULT 0 NOT NULL,
    "perUserLimit" integer DEFAULT 1 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "startsAt" timestamp(3) without time zone,
    "endsAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Coupon" OWNER TO groceries;

--
-- Name: Customer; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Customer" (
    id text NOT NULL,
    phone text NOT NULL,
    email text,
    "passwordHash" text,
    name text,
    "avatarUrl" text,
    "isBlocked" boolean DEFAULT false NOT NULL,
    "currentLatitude" double precision,
    "currentLongitude" double precision,
    "currentLocation" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "staffId" text
);


ALTER TABLE public."Customer" OWNER TO groceries;

--
-- Name: CustomerCoupon; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."CustomerCoupon" (
    id text NOT NULL,
    "customerId" text NOT NULL,
    "couponId" text NOT NULL,
    "usedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."CustomerCoupon" OWNER TO groceries;

--
-- Name: DeliveryChargeRule; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."DeliveryChargeRule" (
    id text NOT NULL,
    "districtId" text,
    name text NOT NULL,
    "minDistance" double precision DEFAULT 0 NOT NULL,
    "maxDistance" double precision,
    charge numeric(65,30) NOT NULL,
    "freeAbove" numeric(65,30),
    "isActive" boolean DEFAULT true NOT NULL,
    "bannerTitle" text,
    "bannerSubtitle" text,
    "bannerIcon" text,
    "bannerBgColor" text,
    "bannerTextColor" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."DeliveryChargeRule" OWNER TO groceries;

--
-- Name: DeviceLocation; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."DeviceLocation" (
    id text NOT NULL,
    "deviceId" text NOT NULL,
    "customerId" text,
    "displayName" text NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    "districtId" text,
    "areaId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."DeviceLocation" OWNER TO groceries;

--
-- Name: District; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."District" (
    id text NOT NULL,
    name text NOT NULL,
    code text NOT NULL,
    latitude double precision,
    longitude double precision,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."District" OWNER TO groceries;

--
-- Name: Inventory; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Inventory" (
    id text NOT NULL,
    "productId" text NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    "reorderLevel" integer DEFAULT 10 NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Inventory" OWNER TO groceries;

--
-- Name: MicroBanner; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."MicroBanner" (
    id text NOT NULL,
    "districtId" text,
    title text NOT NULL,
    "imageUrl" text NOT NULL,
    "linkUrl" text,
    "sortOrder" integer DEFAULT 0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "startsAt" timestamp(3) without time zone,
    "endsAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."MicroBanner" OWNER TO groceries;

--
-- Name: Notification; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Notification" (
    id text NOT NULL,
    "customerId" text,
    "vendorId" text,
    type text NOT NULL,
    title text NOT NULL,
    body text NOT NULL,
    data jsonb,
    "isRead" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Notification" OWNER TO groceries;

--
-- Name: Offer; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Offer" (
    id text NOT NULL,
    title text NOT NULL,
    description text,
    "imageUrl" text,
    scope text NOT NULL,
    "districtId" text,
    "vendorId" text,
    "categoryId" text,
    "discountPct" numeric(65,30),
    "discountAmt" numeric(65,30),
    "minOrder" numeric(65,30),
    "isActive" boolean DEFAULT true NOT NULL,
    "approvalStatus" text DEFAULT 'PENDING'::text NOT NULL,
    "startsAt" timestamp(3) without time zone,
    "endsAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Offer" OWNER TO groceries;

--
-- Name: Order; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Order" (
    id text NOT NULL,
    "orderNumber" text NOT NULL,
    "customerId" text NOT NULL,
    "vendorId" text NOT NULL,
    "addressId" text NOT NULL,
    "paymentId" text,
    status text DEFAULT 'PLACED'::text NOT NULL,
    subtotal numeric(65,30) NOT NULL,
    discount numeric(65,30) DEFAULT 0 NOT NULL,
    "deliveryCharge" numeric(65,30) DEFAULT 0 NOT NULL,
    tax numeric(65,30) DEFAULT 0 NOT NULL,
    "grandTotal" numeric(65,30) NOT NULL,
    "couponCode" text,
    notes text,
    "cancelledAt" timestamp(3) without time zone,
    "cancelReason" text,
    "deliveredAt" timestamp(3) without time zone,
    "settlementId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Order" OWNER TO groceries;

--
-- Name: OrderItem; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."OrderItem" (
    id text NOT NULL,
    "orderId" text NOT NULL,
    "productId" text NOT NULL,
    name text NOT NULL,
    quantity integer NOT NULL,
    "unitPrice" numeric(65,30) NOT NULL,
    total numeric(65,30) NOT NULL
);


ALTER TABLE public."OrderItem" OWNER TO groceries;

--
-- Name: OtpSession; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."OtpSession" (
    id text NOT NULL,
    phone text NOT NULL,
    otp text NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."OtpSession" OWNER TO groceries;

--
-- Name: Payment; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Payment" (
    id text NOT NULL,
    reference text NOT NULL,
    "customerId" text NOT NULL,
    amount numeric(65,30) NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    method text NOT NULL,
    "razorpayOrderId" text,
    "razorpayPayId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Payment" OWNER TO groceries;

--
-- Name: Product; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Product" (
    id text NOT NULL,
    "vendorId" text NOT NULL,
    "categoryId" text NOT NULL,
    "subCategoryId" text,
    name text NOT NULL,
    slug text NOT NULL,
    description text,
    brand text,
    sku text,
    barcode text,
    mrp numeric(65,30) NOT NULL,
    "sellingPrice" numeric(65,30) NOT NULL,
    unit text NOT NULL,
    weight text,
    "weightGrams" double precision,
    "hsnCode" text,
    "taxPct" numeric(65,30) DEFAULT 0 NOT NULL,
    "commissionPct" numeric(65,30) DEFAULT 5 NOT NULL,
    "marginPct" numeric(65,30) DEFAULT 0 NOT NULL,
    tags text,
    status text DEFAULT 'PENDING_APPROVAL'::text NOT NULL,
    "rejectionReason" text,
    "adminNotes" text,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Product" OWNER TO groceries;

--
-- Name: ProductApproval; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."ProductApproval" (
    id text NOT NULL,
    "productId" text NOT NULL,
    "vendorId" text NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    "adminNotes" text,
    "rejectionReason" text,
    "reviewedBy" text,
    "reviewedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."ProductApproval" OWNER TO groceries;

--
-- Name: ProductImage; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."ProductImage" (
    id text NOT NULL,
    "productId" text NOT NULL,
    url text NOT NULL,
    "publicId" text,
    "sortOrder" integer DEFAULT 0 NOT NULL,
    "isPrimary" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."ProductImage" OWNER TO groceries;

--
-- Name: RefreshToken; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."RefreshToken" (
    id text NOT NULL,
    token text NOT NULL,
    "userId" text NOT NULL,
    "userRole" text NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    "deviceName" text,
    "deviceId" text,
    "deviceModel" text,
    "osVersion" text,
    "ipAddress" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."RefreshToken" OWNER TO groceries;

--
-- Name: Review; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Review" (
    id text NOT NULL,
    "customerId" text NOT NULL,
    "productId" text,
    "vendorId" text,
    "orderId" text NOT NULL,
    rating integer NOT NULL,
    comment text,
    "imageUrl" text,
    "isFlagged" boolean DEFAULT false NOT NULL,
    "isVisible" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Review" OWNER TO groceries;

--
-- Name: SearchLog; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."SearchLog" (
    id text NOT NULL,
    "customerId" text,
    query text NOT NULL,
    "districtId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."SearchLog" OWNER TO groceries;

--
-- Name: Staff; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Staff" (
    id text NOT NULL,
    code text NOT NULL,
    name text NOT NULL,
    phone text NOT NULL,
    email text,
    designation text,
    "districtId" text,
    "areaId" text,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Staff" OWNER TO groceries;

--
-- Name: StaffAuditLog; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."StaffAuditLog" (
    id text NOT NULL,
    "staffId" text NOT NULL,
    action text NOT NULL,
    platform text,
    "deviceInfo" text,
    "ipAddress" text,
    metadata text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."StaffAuditLog" OWNER TO groceries;

--
-- Name: StaticPage; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."StaticPage" (
    id text NOT NULL,
    slug text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."StaticPage" OWNER TO groceries;

--
-- Name: SuperAdmin; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."SuperAdmin" (
    id text NOT NULL,
    email text NOT NULL,
    "passwordHash" text NOT NULL,
    name text NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "twoFaEnabled" boolean DEFAULT false NOT NULL,
    "twoFaSecret" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."SuperAdmin" OWNER TO groceries;

CREATE TABLE public."SupportTicket" (
    id text NOT NULL,
    "customerId" text NOT NULL,
    "orderId" text,
    subject text NOT NULL,
    message text NOT NULL,
    status text DEFAULT 'OPEN'::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."SupportTicket" OWNER TO groceries;

CREATE TABLE public."Vendor" (
    id text NOT NULL,
    "areaId" text NOT NULL,
    email text NOT NULL,
    "passwordHash" text NOT NULL,
    "shopName" text NOT NULL,
    code text,
    slug text NOT NULL,
    description text,
    "logoUrl" text,
    "bannerUrl" text,
    address text NOT NULL,
    landmark text,
    latitude double precision,
    longitude double precision,
    phone text NOT NULL,
    "fssaiNumber" text,
    "gstNumber" text,
    "fssaiDocUrl" text,
    "gstDocUrl" text,
    "bankAccountNo" text,
    "bankIfsc" text,
    "bankHolderName" text,
    status text DEFAULT 'PENDING'::text NOT NULL,
    "rejectionReason" text,
    "minOrderValue" numeric(65,30) DEFAULT 0 NOT NULL,
    "deliveryRadius" double precision DEFAULT 5 NOT NULL,
    "isOpen" boolean DEFAULT true NOT NULL,
    "operatingHours" jsonb,
    rating double precision DEFAULT 0 NOT NULL,
    "ratingCount" integer DEFAULT 0 NOT NULL,
    "approvedAt" timestamp(3) without time zone,
    "approvedBy" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "districtId" text NOT NULL,
    "customerId" text,
    "staffId" text,
    "staffReferralCode" text,
    "shopCategory" text
);


ALTER TABLE public."Vendor" OWNER TO groceries;

--
-- Name: VendorRequest; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."VendorRequest" (
    id text NOT NULL,
    "customerId" text NOT NULL,
    status text DEFAULT 'DRAFT'::text NOT NULL,
    "shopName" text,
    "ownerName" text,
    "mobileNumber" text,
    email text,
    "shopCategory" text,
    description text,
    "gstNumber" text,
    "fssaiNumber" text,
    "businessRegNumber" text,
    "districtId" text,
    "areaId" text,
    address text,
    landmark text,
    latitude double precision,
    longitude double precision,
    "deliveryRadius" double precision DEFAULT 5,
    "accountHolderName" text,
    "bankName" text,
    "accountNumber" text,
    "ifscCode" text,
    "upiId" text,
    "logoUrl" text,
    "bannerUrl" text,
    "ownerPhotoUrl" text,
    "govtIdUrl" text,
    "gstCertUrl" text,
    "fssaiCertUrl" text,
    "adminRemarks" text,
    "rejectionReason" text,
    "reviewedBy" text,
    "reviewedAt" timestamp(3) without time zone,
    "submittedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "staffReferralCode" text,
    "staffId" text
);


ALTER TABLE public."VendorRequest" OWNER TO groceries;

--
-- Name: VendorSettlement; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."VendorSettlement" (
    id text NOT NULL,
    "vendorId" text NOT NULL,
    "settlementNo" text NOT NULL,
    "periodStart" timestamp(3) without time zone NOT NULL,
    "periodEnd" timestamp(3) without time zone NOT NULL,
    "totalOrders" integer DEFAULT 0 NOT NULL,
    "grossAmount" numeric(65,30) DEFAULT 0 NOT NULL,
    "commissionAmount" numeric(65,30) DEFAULT 0 NOT NULL,
    "gstAmount" numeric(65,30) DEFAULT 0 NOT NULL,
    "platformFee" numeric(65,30) DEFAULT 0 NOT NULL,
    "netAmount" numeric(65,30) DEFAULT 0 NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    "bankReference" text,
    "rejectionReason" text,
    "approvedBy" text,
    "approvedAt" timestamp(3) without time zone,
    "paidAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."VendorSettlement" OWNER TO groceries;

--
-- Name: VendorStaff; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."VendorStaff" (
    id text NOT NULL,
    "vendorId" text NOT NULL,
    email text NOT NULL,
    "passwordHash" text NOT NULL,
    name text NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."VendorStaff" OWNER TO groceries;

--
-- Name: VendorWallet; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."VendorWallet" (
    id text NOT NULL,
    "vendorId" text NOT NULL,
    balance numeric(65,30) DEFAULT 0 NOT NULL,
    "totalEarned" numeric(65,30) DEFAULT 0 NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."VendorWallet" OWNER TO groceries;

--
-- Name: VendorWalletTransaction; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."VendorWalletTransaction" (
    id text NOT NULL,
    "vendorId" text NOT NULL,
    "settlementId" text,
    type text NOT NULL,
    amount numeric(65,30) NOT NULL,
    "balanceAfter" numeric(65,30) NOT NULL,
    description text NOT NULL,
    reference text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."VendorWalletTransaction" OWNER TO groceries;

--
-- Name: Wallet; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Wallet" (
    id text NOT NULL,
    "customerId" text NOT NULL,
    balance numeric(65,30) DEFAULT 0 NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Wallet" OWNER TO groceries;

--
-- Name: WalletTransaction; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."WalletTransaction" (
    id text NOT NULL,
    "walletId" text NOT NULL,
    type text NOT NULL,
    amount numeric(65,30) NOT NULL,
    description text NOT NULL,
    reference text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."WalletTransaction" OWNER TO groceries;

--
-- Name: Wishlist; Type: TABLE; Schema: public; Owner: groceries
--

CREATE TABLE public."Wishlist" (
    id text NOT NULL,
    "customerId" text NOT NULL,
    "productId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Wishlist" OWNER TO groceries;

--
-- Data for Name: Address; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Address" (id, "customerId", label, line1, line2, city, state, pincode, latitude, longitude, "isDefault", "createdAt", "updatedAt") FROM stdin;
cmto1ah0w000wc6qn5zebnrw9	cmtmmk473001yc6dk3hc8mcv2	Home	Teat	\N	Dharmapuri	Tamil Nadu	636902	11.2750806	77.5799035	f	2026-09-05 07:00:54.32	2026-09-05 07:00:54.32
cmtobc187004nc6qnp8crwz8l	cmtob892m003xc6qnqhmxp8lu	Home	Elur	\N	Eroe	Tamil Nadu	638506	11.5064267	77.3607933	f	2026-09-05 11:42:03.32	2026-09-05 11:42:03.32
cmv0fwvik000fc69xh98hbujv	cmtnu3xt8003tc6dkmpc9rycj	Home	Erode	\N	Erode	Tamil Nadu	638311	11.2751142	77.5798455	f	2026-10-09 04:03:10.604	2026-10-09 04:03:10.604
\.


--
-- Data for Name: AppSetting; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."AppSetting" (id, key, value, "updatedAt") FROM stdin;
cmtmmie57001xc6dkuyefxxh6	featureFlags	{"cod": true, "wallet": false, "ratings": true, "multiVendor": true, "vendorApprovalRequired": false}	2026-10-02 08:22:31.791
cmtmmie4p001rc6dk4u5cutp6	minOrderValue	99	2026-10-02 08:22:31.779
cmtmmie4y001sc6dki1741pva	taxPercent	5	2026-10-02 08:22:31.782
cmtmmie4z001tc6dkz268xi1u	platformFee	5	2026-10-02 08:22:31.784
cmtmmie51001uc6dkswfk2zw7	deliveryFee	0	2026-10-02 08:22:31.785
cmtvry3eb000ac6w8u76nsw9t	isDeliveryKmBased	false	2026-10-02 08:22:31.786
cmtvry3ef000bc6w8w3tnm9p8	deliveryFeePerKm	10	2026-10-02 08:22:31.787
cmtmmie52001vc6dkhvs4ht0x	minAppVersion	"0.1.5"	2026-10-02 08:22:31.789
cmtmmie56001wc6dkfec01cu8	playStoreUrl	"https://play.google.com/store/apps/details?id=com.alltimemarket.app"	2026-10-02 08:22:31.79
\.


--
-- Data for Name: Area; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Area" (id, "districtId", name, pincode, latitude, longitude, "isActive", "createdAt", "updatedAt") FROM stdin;
cmto12z7k0001c6qnenvc4c87	cmtns0y7d003qc6dkrd484hm1	Main Area	\N	\N	\N	t	2026-09-05 06:55:04.641	2026-09-05 06:55:04.641
cmunrorv7002ec6uvcx6fsb22	cmtns0y7d003qc6dkrd484hm1	PS Park (Periyar Park)	638001	\N	\N	t	2026-09-30 07:11:47.731	2026-09-30 07:11:47.731
cmunros66002gc6uvi65l090s	cmtns0y7d003qc6dkrd484hm1	Brough Road	638001	\N	\N	t	2026-09-30 07:11:48.126	2026-09-30 07:11:48.126
cmunrosav002ic6uvx7ckw2w1	cmtns0y7d003qc6dkrd484hm1	Manikoondu (Clock Tower)	638001	\N	\N	t	2026-09-30 07:11:48.296	2026-09-30 07:11:48.296
cmunrosiq002kc6uvsna3r7b0	cmtns0y7d003qc6dkrd484hm1	Nethaji Market	638001	\N	\N	t	2026-09-30 07:11:48.578	2026-09-30 07:11:48.578
cmunrosn1002mc6uvlp0jpmk0	cmtns0y7d003qc6dkrd484hm1	Gandhiji Road	638001	\N	\N	t	2026-09-30 07:11:48.733	2026-09-30 07:11:48.733
cmunrosrb002oc6uvu649o2aw	cmtns0y7d003qc6dkrd484hm1	Marapalam	638001	\N	\N	t	2026-09-30 07:11:48.887	2026-09-30 07:11:48.887
cmunrosvn002qc6uv94o2k4n7	cmtns0y7d003qc6dkrd484hm1	Erode Railway Station (Junction)	638002	\N	\N	t	2026-09-30 07:11:49.044	2026-09-30 07:11:49.044
cmunrot04002sc6uvwi03p8sk	cmtns0y7d003qc6dkrd484hm1	Kollampalayam	638002	\N	\N	t	2026-09-30 07:11:49.205	2026-09-30 07:11:49.205
cmunrot4c002uc6uv2hpf98hy	cmtns0y7d003qc6dkrd484hm1	Moolapalayam	638002	\N	\N	t	2026-09-30 07:11:49.356	2026-09-30 07:11:49.356
cmunrot8s002wc6uv5sixdts9	cmtns0y7d003qc6dkrd484hm1	Vendipalayam	638002	\N	\N	t	2026-09-30 07:11:49.517	2026-09-30 07:11:49.517
cmunrotd2002yc6uvmjff1e90	cmtns0y7d003qc6dkrd484hm1	Solar (New Bus Stand)	638002	\N	\N	t	2026-09-30 07:11:49.671	2026-09-30 07:11:49.671
cmunroth70030c6uv0bdtqxp6	cmtns0y7d003qc6dkrd484hm1	Lakkapuram	638002	\N	\N	t	2026-09-30 07:11:49.819	2026-09-30 07:11:49.819
cmunrotlo0032c6uvr9huj6xf	cmtns0y7d003qc6dkrd484hm1	Karungalpalayam	638003	\N	\N	t	2026-09-30 07:11:49.981	2026-09-30 07:11:49.981
cmunrotq40034c6uv4idr6lm5	cmtns0y7d003qc6dkrd484hm1	Cauvery Road	638003	\N	\N	t	2026-09-30 07:11:50.14	2026-09-30 07:11:50.14
cmunrotu60036c6uvurlwszax	cmtns0y7d003qc6dkrd484hm1	Sathy Road	638003	\N	\N	t	2026-09-30 07:11:50.287	2026-09-30 07:11:50.287
cmunrotyc0038c6uvdrk1hk92	cmtns0y7d003qc6dkrd484hm1	Veerappanchatram	638004	\N	\N	t	2026-09-30 07:11:50.436	2026-09-30 07:11:50.436
cmunrou2k003ac6uvkw98ezrr	cmtns0y7d003qc6dkrd484hm1	Kanirowther Kulam	638004	\N	\N	t	2026-09-30 07:11:50.589	2026-09-30 07:11:50.589
cmunrou6q003cc6uviu2pmo1x	cmtns0y7d003qc6dkrd484hm1	BP Agraharam	638005	\N	\N	t	2026-09-30 07:11:50.738	2026-09-30 07:11:50.738
cmunroub4003ec6uvrtf2r2cq	cmtns0y7d003qc6dkrd484hm1	Surampatti	638009	\N	\N	t	2026-09-30 07:11:50.896	2026-09-30 07:11:50.896
cmunroufo003gc6uvl3fu5ha1	cmtns0y7d003qc6dkrd484hm1	Surampatti Valasu	638009	\N	\N	t	2026-09-30 07:11:51.061	2026-09-30 07:11:51.061
cmunroujt003ic6uvqhkrqbt1	cmtns0y7d003qc6dkrd484hm1	Kasipalayam	638009	\N	\N	t	2026-09-30 07:11:51.21	2026-09-30 07:11:51.21
cmunrouo0003kc6uv5lt7u3yv	cmtns0y7d003qc6dkrd484hm1	Rangampalayam	638009	\N	\N	t	2026-09-30 07:11:51.36	2026-09-30 07:11:51.36
cmunrous9003mc6uv61qcdo88	cmtns0y7d003qc6dkrd484hm1	Vettukattuvalasu	638009	\N	\N	t	2026-09-30 07:11:51.514	2026-09-30 07:11:51.514
cmunrouwf003oc6uvkw5jmrib	cmtns0y7d003qc6dkrd484hm1	Perundurai Road	638011	\N	\N	t	2026-09-30 07:11:51.663	2026-09-30 07:11:51.663
cmunrov0o003qc6uv48tq4mtl	cmtns0y7d003qc6dkrd484hm1	Sampath Nagar	638011	\N	\N	t	2026-09-30 07:11:51.816	2026-09-30 07:11:51.816
cmunrov8w003sc6uvjdtgn86y	cmtns0y7d003qc6dkrd484hm1	Kumalan Kuttai	638011	\N	\N	t	2026-09-30 07:11:52.112	2026-09-30 07:11:52.112
cmunrovde003uc6uvsvx2a4p4	cmtns0y7d003qc6dkrd484hm1	Palayapalayam	638011	\N	\N	t	2026-09-30 07:11:52.275	2026-09-30 07:11:52.275
cmunrovhk003wc6uvh6oi2h60	cmtns0y7d003qc6dkrd484hm1	Teachers Colony	638011	\N	\N	t	2026-09-30 07:11:52.424	2026-09-30 07:11:52.424
cmunrovlo003yc6uvzfgefn7z	cmtns0y7d003qc6dkrd484hm1	Collectorate Area	638011	\N	\N	t	2026-09-30 07:11:52.572	2026-09-30 07:11:52.572
cmunrovqb0040c6uvc65vpr47	cmtns0y7d003qc6dkrd484hm1	Thindal	638012	\N	\N	t	2026-09-30 07:11:52.74	2026-09-30 07:11:52.74
cmunrovui0042c6uvn9g8kagv	cmtns0y7d003qc6dkrd484hm1	Thindal Murugan Temple	638012	\N	\N	t	2026-09-30 07:11:52.891	2026-09-30 07:11:52.891
cmunrovzf0044c6uv2l875vwb	cmtns0y7d003qc6dkrd484hm1	Villarasampatti	638107	\N	\N	t	2026-09-30 07:11:53.067	2026-09-30 07:11:53.067
cmunrow4a0046c6uv5z2mn9w1	cmtns0y7d003qc6dkrd484hm1	Nasiyanur	638107	\N	\N	t	2026-09-30 07:11:53.242	2026-09-30 07:11:53.242
cmunrow8y0048c6uv4jemjw59	cmtns0y7d003qc6dkrd484hm1	Chithode	638102	\N	\N	t	2026-09-30 07:11:53.41	2026-09-30 07:11:53.41
cmunrowd1004ac6uvwscb2qo7	cmtns0y7d003qc6dkrd484hm1	Bhavani	638301	\N	\N	t	2026-09-30 07:11:53.558	2026-09-30 07:11:53.558
cmunrowh8004cc6uvogjo9cco	cmtns0y7d003qc6dkrd484hm1	Perundurai	638052	\N	\N	t	2026-09-30 07:11:53.708	2026-09-30 07:11:53.708
cmunrowmf004ec6uvdw30qjjn	cmtns0y7d003qc6dkrd484hm1	Modakkurichi	638104	\N	\N	t	2026-09-30 07:11:53.895	2026-09-30 07:11:53.895
cmunrowrd004gc6uv6pfdv63e	cmtns0y7d003qc6dkrd484hm1	Avalpoondurai	638115	\N	\N	t	2026-09-30 07:11:54.074	2026-09-30 07:11:54.074
cmunrowvg004ic6uvk6gm06o1	cmtns0y7d003qc6dkrd484hm1	Chennimalai	638051	\N	\N	t	2026-09-30 07:11:54.22	2026-09-30 07:11:54.22
cmunrowzl004kc6uvfc4p7ee1	cmtns0y7d003qc6dkrd484hm1	Kodumudi	638151	\N	\N	t	2026-09-30 07:11:54.37	2026-09-30 07:11:54.37
cmunrox3v004mc6uvcbaqmj8f	cmtns0y7d003qc6dkrd484hm1	Gobichettipalayam	638452	\N	\N	t	2026-09-30 07:11:54.524	2026-09-30 07:11:54.524
cmunrox88004oc6uvg2kuvk9a	cmtns0y7d003qc6dkrd484hm1	Sathyamangalam	638402	\N	\N	t	2026-09-30 07:11:54.681	2026-09-30 07:11:54.681
cmunroxci004qc6uvtdizj08u	cmtns0y7d003qc6dkrd484hm1	Anthiyur	638501	\N	\N	t	2026-09-30 07:11:54.834	2026-09-30 07:11:54.834
\.


--
-- Data for Name: AuditLog; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."AuditLog" (id, "actorType", "actorId", "actorName", action, "entityType", "entityId", details, "ipAddress", "createdAt") FROM stdin;
\.


--
-- Data for Name: Banner; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Banner" (id, "districtId", title, "imageUrl", "videoUrl", type, "row", "linkUrl", "themeColor", "themeColorEnd", "sortOrder", "isActive", "startsAt", "endsAt", "createdAt", "updatedAt") FROM stdin;
cmucep5h7002fc6u67fypxueu	\N	Bharatham Traders 	https://api.alltimemarket.in/uploads/all-time-market/districtmart-banners/f2109e9c-4f2f-4c94-830b-7072904afad1.webp	\N	IMAGE	3	\N	#16a34a	#4ade80	0	t	\N	\N	2026-09-22 08:22:42.422	2026-10-01 18:51:09.985
cmtpn8q540076c6qnt169ielq	\N	VMS TRADERS 	http://localhost:4000/uploads/all-time-market/districtmart-banners/bc284654-c696-4a2a-ae84-d267bdde9bee.webp	\N	IMAGE	2	\N	#16a34a	#4ade80	0	t	\N	\N	2026-09-06 10:03:10.552	2026-09-08 05:41:24.08
cmtodayvx005vc6qn9k30bqy3	\N	Sowmi makeup studio 	http://localhost:4000/uploads/all-time-market/districtmart-banners/328b26c0-e3b4-4198-a753-82a3eb4c7773.webp	\N	IMAGE	1	\N	#16a34a	#4ade80	0	t	\N	\N	2026-09-05 12:37:12.861	2026-09-08 05:45:03.6
cmtod7k9q005uc6qn2tkx8gwz	\N	gs centering	http://localhost:4000/uploads/all-time-market/districtmart-banners/5a83f9fa-b8d7-404c-9493-7466862cf05c.webp	\N	IMAGE	2	\N	#16a34a	#4ade80	0	t	\N	\N	2026-09-05 12:34:33.944	2026-09-08 05:48:16.368
cmu0kq0lr003zc63v8j7xx7kl	\N	Pet shop	https://api.alltimemarket.in/uploads/all-time-market/districtmart-banners/585f3555-62a6-44ab-b8a3-1d3ff01c1bfa.webp	\N	IMAGE	3	\N	#16a34a	#4ade80	0	t	\N	\N	2026-09-14 01:38:06.35	2026-10-01 18:51:09.99
cmucem909002dc6u6drq9lxwz	\N	Bharatham Traders 	https://api.alltimemarket.in/uploads/all-time-market/districtmart-banners/1e22dd6f-8fb5-4c54-8b4b-db0d87d2c953.webp	\N	IMAGE	1	\N	#16a34a	#4ade80	0	t	\N	\N	2026-09-22 08:20:27.033	2026-10-01 18:51:09.991
cmucenf48002ec6u6do7jew67	\N	Niruthi womens beauty parlour 	https://api.alltimemarket.in/uploads/all-time-market/districtmart-banners/b698bd33-02af-444a-a400-4b45bc8010d8.webp	\N	IMAGE	3	\N	#16a34a	#4ade80	0	t	\N	\N	2026-09-22 08:21:21.608	2026-10-01 18:51:09.992
cmtwkngx8001ac6w8855jeyew	\N	Zhi dimensions 	http://localhost:4000/uploads/all-time-market/districtmart-banners/8a36bc0d-0916-4938-ace1-fae6a48bcd29.webp	\N	IMAGE	1	\N	#16a34a	#4ade80	0	t	\N	\N	2026-09-11 06:25:02.828	2026-09-11 06:25:02.828
cmtwwtoiy000gc68mg0b1px18	\N	Zhi dimensions	https://api.alltimemarket.in/uploads/all-time-market/districtmart-banners/1725eb69-d60c-4e39-ace0-c932a9b41e02.webp	\N	IMAGE	2	\N	#16a34a	#4ade80	0	f	\N	\N	2026-09-11 12:05:48.01	2026-10-02 08:20:43.42
\.


--
-- Data for Name: CartItem; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."CartItem" (id, "customerId", "vendorId", "productId", quantity, "createdAt", "updatedAt") FROM stdin;
cmttn79kr000lc60pjqs590tz	cmtq13ewh0078c6qnv0cluhfe	cmto6hp41001ic6qnofm37rw5	cmtoazvz30029c6qnpt1yvwxl	1	2026-09-09 05:13:07.131	2026-09-09 05:13:07.131
cmu9r7xfx001ac6u6xbbmvcq7	cmu9r5vv80014c6u68omb5oda	cmto12z7q0003c6qngfgz5u4c	cmu6b9hzu001jc644ngvyav1b	1	2026-09-20 11:49:55.341	2026-09-20 11:49:55.341
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Category" (id, "parentId", name, slug, "imageUrl", "sortOrder", "isActive", "createdAt", "updatedAt") FROM stdin;
cmtlr6o3w0006c6suja1ozk3n	\N	Beauty	beauty	http://localhost:4000/uploads/all-time-market/districtmart-categories/f714cbbc-fed1-4b9d-9b04-b819ab627089.webp	7	t	2026-09-03 16:42:28.364	2026-09-30 11:50:42.516
cmtlr6o3h0000c6suadgx4p2e	\N	Men's Clothing	mens-clothing	http://localhost:4000/uploads/all-time-market/districtmart-categories/8e706559-db82-4f84-9beb-202e163a683d.webp	1	t	2026-09-03 16:42:28.349	2026-09-30 11:50:56.545
cmtlr6o3u0005c6suhgmgv3vf	\N	Women & Kids	women-kids	http://localhost:4000/uploads/all-time-market/districtmart-categories/2cd0439d-b050-48c8-9c0a-f2bd475e7fda.webp	6	t	2026-09-03 16:42:28.363	2026-09-30 11:51:03.795
cmtlr6o49000ec6surcwc3poj	\N	Snacks & Drinks	snacks-drinks	http://localhost:4000/uploads/all-time-market/districtmart-categories/acc5761f-e9be-469b-b272-21ab06cb0cf0.webp	15	t	2026-09-03 16:42:28.377	2026-09-30 11:51:11.64
cmughfcz40032c6u6spvv6qmq	\N	Printing press 	Invitation,Notice	https://api.alltimemarket.in/uploads/all-time-market/districtmart-categories/a3dfcf19-c316-46df-91e9-ad32df7c02dd.webp	0	t	2026-09-25 04:50:09.136	2026-10-01 18:51:09.981
cmu15y3i2000ac644afmn1lth	\N	Handmade & Crafts	Handmade & Crafts	https://api.alltimemarket.in/uploads/all-time-market/districtmart-categories/d8d6abf7-023a-4065-9c04-7c9d6b7b5998.webp	0	t	2026-09-14 11:32:15.29	2026-10-01 18:51:09.983
cmtlr6o48000dc6suhtx0pls5	\N	Meat & Seafood	meat-seafood	\N	14	t	2026-09-03 16:42:28.376	2026-10-04 05:56:20.188
cmtlr6o3n0001c6sufojrf3du	\N	Ayurveda & Pooja	ayurveda-pooja	https://api.alltimemarket.in/uploads/all-time-market/districtmart-categories/3bec4fec-a061-473e-814a-fd33d2b549ef.webp	2	t	2026-09-03 16:42:28.355	2026-10-04 05:56:37.311
cmtlr6o3p0002c6su7cjf15cd	\N	Water & Plates	water-plates	https://api.alltimemarket.in/uploads/all-time-market/districtmart-categories/7a71f820-ab56-4f96-8121-8462427a514e.webp	3	t	2026-09-03 16:42:28.357	2026-10-04 05:56:47.562
cmtlr6o3q0003c6su9t27m1xu	\N	Flowers	flowers	https://api.alltimemarket.in/uploads/all-time-market/districtmart-categories/07ea34a8-cd08-4340-a760-e75ed574c4e1.webp	4	t	2026-09-03 16:42:28.359	2026-10-04 05:56:59.865
cmtlr6o3s0004c6sumelt74rf	\N	Finance	finance	https://api.alltimemarket.in/uploads/all-time-market/districtmart-categories/e6b90cb9-184e-4791-96f3-d35a0978ebf6.webp	5	t	2026-09-03 16:42:28.36	2026-10-04 05:57:08.347
cmtlr6o3y0007c6su2h28ocpq	\N	Steel	steel	https://api.alltimemarket.in/uploads/all-time-market/districtmart-categories/122294d8-653a-40a3-b45e-92c096304767.webp	8	t	2026-09-03 16:42:28.366	2026-10-04 05:57:27.122
cmtlr6o3z0008c6suouci7l8w	\N	Wood	wood	\N	9	t	2026-09-03 16:42:28.368	2026-10-04 05:57:44.495
cmtlr6o410009c6sugg1go6ha	\N	Restaurants	restaurants	\N	10	t	2026-09-03 16:42:28.369	2026-10-04 05:57:55.924
cmtlr6o42000ac6sujsoup3uh	\N	Groceries	groceries	\N	11	t	2026-09-03 16:42:28.371	2026-10-04 05:58:04.545
cmtlr6o45000bc6suu4k5g6is	\N	Fruits & Veg	fruits-veg	\N	12	t	2026-09-03 16:42:28.373	2026-10-04 05:58:12.905
cmtlr6o46000cc6su39ds5ay7	\N	Dairy & Bakery	dairy-bakery	\N	13	t	2026-09-03 16:42:28.375	2026-10-04 05:58:21.013
\.


--
-- Data for Name: Coupon; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Coupon" (id, code, description, scope, "vendorId", "categoryId", "discountPct", "discountAmt", "minOrder", "maxDiscount", "usageLimit", "usedCount", "perUserLimit", "isActive", "startsAt", "endsAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Customer; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Customer" (id, phone, email, "passwordHash", name, "avatarUrl", "isBlocked", "currentLatitude", "currentLongitude", "currentLocation", "createdAt", "updatedAt", "staffId") FROM stdin;
cmtmrl33p0027c6dknt5h6xfq	9865930083	\N	\N	\N	\N	f	\N	\N	\N	2026-09-04 09:41:27.158	2026-09-04 09:41:27.158	\N
cmtnu3xt8003tc6dkmpc9rycj	9025255639	\N	\N	\N	\N	f	\N	\N	\N	2026-09-05 03:39:52.172	2026-09-05 03:39:52.172	\N
cmtob892m003xc6qnqhmxp8lu	9840533138	\N	\N	\N	\N	f	\N	\N	\N	2026-09-05 11:39:06.863	2026-09-05 11:39:06.863	\N
cmtoieuv2006ac6qnr401s5nu	9500559718	\N	\N	\N	\N	f	\N	\N	\N	2026-09-05 15:00:12.351	2026-09-05 15:00:12.351	\N
cmtpdn15d006zc6qn5ywssend	8056888119	\N	\N	\N	\N	f	\N	\N	\N	2026-09-06 05:34:21.841	2026-09-06 05:34:21.841	\N
cmtq18z7d007cc6qnwch0now5	9944932484	\N	\N	\N	\N	f	\N	\N	\N	2026-09-06 16:35:16.922	2026-09-06 16:35:16.922	\N
cmtq13ewh0078c6qnv0cluhfe	6380650638	mothizhan18062010@gmail.com	\N	Mothizhan	\N	f	\N	\N	\N	2026-09-06 16:30:57.329	2026-09-06 16:58:53.046	\N
cmtqxh2y4008ic6qngsyygee0	7708168874	\N	\N	\N	\N	f	\N	\N	\N	2026-09-07 07:37:22.733	2026-09-07 07:37:22.733	\N
cmtqydagw0097c6qnh0nc7eqk	9976169926	\N	\N	\N	\N	f	\N	\N	\N	2026-09-07 08:02:25.473	2026-09-07 08:02:25.473	\N
cmuv886sy002yc61ph3wajcek	9790152538	\N	\N	\N	\N	f	\N	\N	\N	2026-10-05 12:29:10.643	2026-10-05 12:29:10.643	\N
cmtmoclyv0022c6dkyi415t8r	9944533403	\N	\N	\N	\N	f	11.4538652	77.4371778	Gobichettipalaiyam, Erode	2026-09-04 08:10:52.855	2026-09-10 14:51:53.446	\N
cmuv8nppz0034c61p4xexy2vq	9500951164	\N	\N	\N	\N	f	\N	\N	\N	2026-10-05 12:41:14.999	2026-10-05 12:41:14.999	\N
cmtwwv0pe000hc68mbz6pyu1g	9841984524	\N	\N	\N	\N	f	\N	\N	\N	2026-09-11 12:06:50.45	2026-09-11 12:06:50.45	\N
cmtx2lp6i0002c63v8xu2kvn8	9942777322	\N	\N	\N	\N	f	\N	\N	\N	2026-09-11 14:47:33.307	2026-09-11 14:47:33.307	\N
cmtvlfvrl0016c68ctku1w5rk	6374244490	\N	\N	\N	\N	f	12.1767478	78.5758439	Harur, Dharmapuri	2026-09-10 13:59:22.257	2026-09-11 16:44:59.529	\N
cmtyk8ja2002gc63vyvx2sds3	9944551098	\N	\N	\N	\N	f	\N	\N	\N	2026-09-12 15:48:58.394	2026-09-12 15:48:58.394	\N
cmtztni07003dc63v3wiwnag1	9597771524	\N	\N	\N	\N	f	\N	\N	\N	2026-09-13 13:00:19.303	2026-09-13 13:00:19.303	\N
cmu0qc0pn0040c63vqxsyqfw0	6379922867	\N	\N	\N	\N	f	\N	\N	\N	2026-09-14 04:15:11.004	2026-09-14 04:15:11.004	\N
cmu12488q0046c63vfoalw0vq	9578627642	\N	\N	\N	\N	f	\N	\N	\N	2026-09-14 09:45:02.906	2026-09-14 09:45:02.906	\N
cmu6qngms003gc644qucmszcs	6381510489	nivatha98@gmail.com	\N	Nivetha	\N	f	\N	\N	\N	2026-09-18 09:10:41.908	2026-10-05 16:16:39.89	\N
cmu26ie5b000kc644sbz5snin	6383352231	\N	\N	\N	\N	f	\N	\N	\N	2026-09-15 04:35:48.383	2026-09-15 04:35:48.383	\N
cmu28je6x000nc6449oc5f25j	9025666069	\N	\N	\N	\N	f	11.2751355	77.5798222	Sanitorium, Perundurai, Erode	2026-09-15 05:32:34.33	2026-09-15 05:33:16.297	\N
cmu28pbx5000vc644mn66ku0x	9643311407	\N	\N	\N	\N	f	11.4546846	77.4363118	Udhagamandalam - Kotagiri - Mettupalayam - Sathy - Gobi - Erode Road, Gobichettipalaiyam, Erode	2026-09-15 05:37:11.321	2026-09-15 06:08:38.855	\N
cmu5s6rnq001dc644odckzmfj	8825557574	\N	\N	\N	\N	f	11.4570471	77.4385224	Gobichettipalaiyam, Erode	2026-09-17 17:05:56.101	2026-09-17 17:07:09.384	\N
cmu6chg81001vc644q7a5i134	8122835447	\N	\N	\N	\N	f	\N	\N	\N	2026-09-18 02:34:06.818	2026-09-18 02:34:06.818	\N
cmtwzsg5a000kc68mg01auon4	9344938459	\N	\N	\N	\N	f	\N	\N	\N	2026-09-11 13:28:49.343	2026-09-18 05:04:20.451	\N
cmuuu2gxe000hc61pkrbihfzc	9791280137	\N	\N	\N	\N	f	\N	\N	\N	2026-10-05 05:52:49.202	2026-10-06 01:54:33.181	\N
cmutexr3e0001c61p5lwz160m	7373479123	\N	\N	A to Z Service 	\N	f	\N	\N	\N	2026-10-04 06:01:28.683	2026-10-06 01:54:36.565	\N
cmu6l1usu003bc644v5ncw3gn	7094598551	\N	\N	\N	\N	f	\N	\N	\N	2026-09-18 06:33:55.758	2026-09-18 06:33:55.758	\N
cmtmmk473001yc6dk3hc8mcv2	9344193569	\N	\N	Jeena	\N	f	11.2751368	77.5798148	Sanitorium, Perundurai, Erode	2026-09-04 07:20:43.839	2026-09-18 09:47:49.594	\N
cmu01265v003kc63vin8jkqo4	9788828179	\N	\N	\N	\N	f	11.5069641	77.3839301	Thuckanaivkampalayam, Erode	2026-09-13 16:27:41.108	2026-09-18 12:46:03.495	\N
cmu73iqmh000fc6u6xx8ozhtp	7348893579	\N	\N	\N	\N	f	\N	\N	\N	2026-09-18 15:10:56.585	2026-09-18 15:10:56.585	\N
cmu85r14h000zc6u63edpsf03	9345149338	\N	\N	\N	\N	f	\N	\N	\N	2026-09-19 09:01:08.849	2026-09-19 09:01:08.849	\N
cmu9r5vv80014c6u68omb5oda	8903679997	\N	\N	\N	\N	f	11.6486723	77.7571822	Nerunjipettai, Erode	2026-09-20 11:48:19.988	2026-09-20 11:49:19.358	\N
cmu6ckauf0029c6445fzyiihf	9363337583	\N	\N	\N	\N	f	11.4512081	77.6863712	Bhavani, Erode	2026-09-18 02:36:19.815	2026-09-22 12:57:13.237	\N
cmumu0yrj0002c6uvxrwj02fv	8072938050	\N	\N	\N	\N	f	\N	\N	\N	2026-09-29 15:29:29.599	2026-09-29 15:29:29.599	\N
cmuno5h2w0008c6uvkn4m9h60	7200473403	pavi.ravicm@gmail.com	\N	Pallavi Ravichandran	\N	f	11.5108649	77.3831231	Thuckanaivkampalayam, Erode	2026-09-30 05:32:48.441	2026-09-30 06:04:41.88	\N
cmunpkdvh0015c6uv8z2uqouz	7695943636	\N	\N	\N	\N	f	\N	\N	\N	2026-09-30 06:12:23.742	2026-09-30 06:12:23.742	\N
cmunrdko30020c6uvldpb1kt8	9876338738	\N	\N	\N	\N	f	\N	\N	\N	2026-09-30 07:03:05.188	2026-09-30 07:03:05.188	\N
cmunreekn0027c6uvcq517li0	9876999222	\N	\N	\N	\N	f	\N	\N	\N	2026-09-30 07:03:43.944	2026-09-30 07:03:43.944	\N
cmuntrw5o0000c683ml9jqd1l	6381027847	\N	\N	\N	\N	f	\N	\N	\N	2026-09-30 08:10:12.493	2026-09-30 08:10:12.493	\N
cmupba85c0012c6i771dg695z	9239643212	\N	\N	\N	\N	f	\N	\N	\N	2026-10-01 09:08:07.489	2026-10-01 09:08:07.489	\N
cmuo0v8ay0009c6i7yrv0ttra	9842712478	boomikar3745@gmail.com	\N	Boomika	\N	f	\N	\N	\N	2026-09-30 11:28:45.514	2026-10-02 10:25:08.317	\N
cmuqtocio001pc69bwhbjrq90	9080359113	\N	\N	\N	\N	f	\N	\N	\N	2026-10-02 10:30:45.6	2026-10-02 10:30:45.6	\N
cmus31ter0033c69bpbuxoqnk	9384825200	kasthurikarikaa@gmail.com	\N	Kasthurikarikaa	\N	f	\N	\N	\N	2026-10-03 07:40:56.739	2026-10-03 07:46:03.019	\N
cmus7nzrl0037c69bs79ds5fc	8838587317	\N	\N	\N	\N	f	\N	\N	\N	2026-10-03 09:50:09.874	2026-10-03 09:50:09.874	\N
cmuscskmq003bc69b9uy2g9u3	9659968146	\N	\N	\N	\N	f	\N	\N	\N	2026-10-03 12:13:41.618	2026-10-03 12:13:41.618	\N
cmuv6h7z4001rc61p12b47c8x	8883532444	\N	\N	\N	\N	f	\N	\N	\N	2026-10-05 11:40:12.832	2026-10-06 01:54:53.864	\N
cmv0fpc4u0005c69xkz6p337x	6382948849	\N	\N	\N	\N	f	\N	\N	\N	2026-10-09 03:57:18.895	2026-10-09 03:57:18.895	\N
cmv0fqywk000bc69xd760sie9	9865862570	\N	\N	\N	\N	f	\N	\N	\N	2026-10-09 03:58:35.06	2026-10-09 03:58:35.06	\N
\.


--
-- Data for Name: CustomerCoupon; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."CustomerCoupon" (id, "customerId", "couponId", "usedAt", "createdAt") FROM stdin;
\.


--
-- Data for Name: DeliveryChargeRule; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."DeliveryChargeRule" (id, "districtId", name, "minDistance", "maxDistance", charge, "freeAbove", "isActive", "bannerTitle", "bannerSubtitle", "bannerIcon", "bannerBgColor", "bannerTextColor", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: DeviceLocation; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."DeviceLocation" (id, "deviceId", "customerId", "displayName", latitude, longitude, "districtId", "areaId", "createdAt", "updatedAt") FROM stdin;
cmu0114f4003jc63vt0idpcv1	6853e0297616a5db	cmu01265v003kc63vin8jkqo4	Thuckanaivkampalayam, Erode	11.5069641	77.3839301	\N	\N	2026-09-13 16:26:52.192	2026-09-18 12:46:03.483
cmu73i3td000ec6u6lfj0y3gf	3610aae1d4dc55f0	\N	NH948, Satyamangalam, Erode	11.5038875	77.242677	\N	\N	2026-09-18 15:10:27.024	2026-09-18 15:10:27.024
cmu85nqfg000uc6u6kqsyzp0v	1a0c0a74349c1979	\N	Anthiyur, Erode	11.5760195	77.5809936	\N	\N	2026-09-19 08:58:35.02	2026-09-19 08:58:35.02
cmu9r75nw0018c6u6ah2l4590	b325ce328c430560	cmu9r5vv80014c6u68omb5oda	Nerunjipettai, Erode	11.6486723	77.7571822	\N	\N	2026-09-20 11:49:19.341	2026-09-20 11:49:19.341
cmub97tdh001vc6u62t1qxuag	93bbe0e03c4e0a80	\N	Anthiyur, Erode	11.5981114	77.5874417	\N	\N	2026-09-21 13:01:29.333	2026-09-21 13:01:29.333
cmuc26pix001xc6u6kkexhl23	664d08b121c56d0d	\N	Satyamangalam, Erode	11.494852	77.23343	\N	\N	2026-09-22 02:32:26.552	2026-09-22 02:32:26.552
cmubey9ah001wc6u66k5r4m81	310e71ede4ce7208	\N	Satyamangalam, Erode	11.5142967	77.2364	\N	\N	2026-09-21 15:42:01.098	2026-09-22 04:03:57.452
cmuc90hoq0028c6u6xf0gqgfe	9572580ffe5fa38d	\N	Anthiyur - Athani Road, Anthiyur, Erode	11.5304305	77.5337569	\N	\N	2026-09-22 05:43:33.771	2026-09-22 05:45:00.176
cmtnuvwna003wc6dk2cj6k6lm	dev_1788165830230_7q8jssttg	\N	Sanitorium, Perundurai, Erode	11.2751	77.5799	\N	\N	2026-09-05 04:01:37.031	2026-09-05 04:01:37.031
cmtnvp58v003xc6dk05ntam5a	5e52bfa0788e868e	\N	Sanitorium, Perundurai, Erode	11.2751021	77.5798806	\N	\N	2026-09-05 04:24:21.2	2026-09-05 04:24:21.2
cmu6cjnt50028c644lxbw7vs6	b9fa1a68005d27b3	cmu6ckauf0029c6445fzyiihf	Bhavani, Erode	11.4512081	77.6863712	\N	\N	2026-09-18 02:35:49.961	2026-09-22 12:57:13.225
cmtwwq9qt000ac68mehat09ny	7a12df252ac86694	\N	Vaniputhur, Erode	11.5064167	77.3610167	\N	\N	2026-09-11 12:03:08.885	2026-09-11 12:03:08.885
cmtx2k63w0001c63vfzz47ewg	d9a91f3ed5369fee	\N	Gobichettipalayam, Erode	11.5020343	77.356669	\N	\N	2026-09-11 14:46:21.932	2026-09-11 14:46:21.932
cmtx6yqxf000fc63vtunocc9y	5f0d863446898060	\N	Kumbakonam	10.9601852	79.3844976	\N	\N	2026-09-11 16:49:40.563	2026-09-11 16:49:40.563
cmtz8z5ks002yc63vdbulqkk8	3a69718dd2de6073	\N	Kurumanthur, Erode	11.40668	77.3472417	\N	\N	2026-09-13 03:21:31.133	2026-09-13 03:21:31.133
cmtztmq52003cc63vfv81kmq9	e0d0bfa7a0521f97	\N	Kallippatti, Erode	11.5066326	77.3827324	\N	\N	2026-09-13 12:59:43.19	2026-09-13 12:59:43.19
cmtlwu57w001oc6dkuuqzeetv	e57517bbb4eddd73	\N	Amphitheatre Parkway, Mountain View, Santa Clara County	37.4220009	-122.0840607	\N	\N	2026-09-03 19:20:41.708	2026-09-13 14:25:12.572
cmuce510v002ac6u6f7ec78so	35c87c75789ec3e8	\N	Thuckanaivkampalayam, Erode	11.5064046	77.3840693	\N	\N	2026-09-22 08:07:03.535	2026-10-05 05:52:19.5
cmu0ki0mq003yc63vjtirwg09	8cc4c042f2c66e8b	\N	Vaniputhur, Erode	11.5052934	77.360225	\N	\N	2026-09-14 01:31:53.138	2026-09-14 01:31:53.138
cmu123dwf0045c63va0d8gsm3	a9756360c0f60ed4	\N	Gobichettipalaiyam, Erode	11.4559224	77.4354932	\N	\N	2026-09-14 09:44:23.583	2026-09-14 09:44:23.583
cmui5o6fx0038c6u6wxwncau2	77ec6d25c1c3235a	\N	Sanitorium, Perundurai, Erode	11.2752354	77.5799094	\N	\N	2026-09-26 08:56:37.533	2026-09-26 08:56:37.533
cmtoatkt2001tc6qnjv9lcy6m	bcdc1c6e1498974b	\N	Vaniputhur, Erode	11.5065817	77.3610432	\N	\N	2026-09-05 11:27:42.23	2026-09-05 11:27:42.23
cmtob7cth003wc6qnk7ff6ru4	3d3d24c34f733e48	\N	Vaniputhur, Erode	11.5064267	77.3607933	\N	\N	2026-09-05 11:38:25.061	2026-09-05 11:38:25.061
cmtoie2tb0069c6qn070yesej	50c0ac913103af44	\N	Vaniputhur, Erode	11.5065947	77.3612498	\N	\N	2026-09-05 14:59:35.999	2026-09-05 14:59:35.999
cmtpdlsg4006yc6qncji8onos	c71be8b2327c9223	\N	Salem Junction - Yercaud Road, Yercaud, Salem	11.7858743	78.2091424	\N	\N	2026-09-06 05:33:23.908	2026-09-06 05:33:23.908
cmtq17vxp007bc6qnj11c5mom	a75d1641b520690f	\N	Vaniputhur, Erode	11.5060369	77.3606165	\N	\N	2026-09-06 16:34:26.029	2026-09-06 16:34:26.029
cmtqxdul7008gc6qnxi5te4m0	d9a9c77d02e56fce	\N	Avinashi, Tiruppur	11.3138117	77.2433467	\N	\N	2026-09-07 07:34:51.931	2026-09-07 07:36:54.452
cmtrdh7vl009dc6qn2f5q5ds0	211a141fbd5b2945	\N	Perundurai, Erode	11.2855798	77.6007011	\N	\N	2026-09-07 15:05:22.977	2026-09-07 15:05:22.977
cmu26hhvp000jc644sw6kofzv	f9766b2217212d3a	\N	Thuckanaivkampalayam, Erode	11.5077333	77.389065	\N	\N	2026-09-15 04:35:06.565	2026-09-15 04:35:06.565
cmu28kakl000rc644khxbtl00	1beb3305fb5e85d4	cmu28je6x000nc6449oc5f25j	Sanitorium, Perundurai, Erode	11.2751355	77.5798222	\N	\N	2026-09-15 05:33:16.293	2026-09-15 05:33:16.293
cmtnoi8ni002fc6dkd4jh6fsq	37c0c246503697b8	cmtmmk473001yc6dk3hc8mcv2	Sanitorium, Perundurai, Erode	11.2751756	77.579837	\N	\N	2026-09-05 01:03:01.71	2026-10-05 12:07:59.074
cmttnbjbw000mc60ppscxo5w5	bd61f8dd2fa36c80	\N	CA 20, Mendocino County	39.237255	-123.1500317	\N	\N	2026-09-09 05:16:26.397	2026-09-09 05:16:26.397
cmu28oqfd000uc644jufg27w4	60e4f947a6c8cf1b	cmu28pbx5000vc644mn66ku0x	Udhagamandalam - Kotagiri - Mettupalayam - Sathy - Gobi - Erode Road, Gobichettipalaiyam, Erode	11.4546846	77.4363118	\N	\N	2026-09-15 05:36:43.465	2026-09-15 06:08:38.848
cmunpahhs0010c6uvgeb1285l	7d596b709fda74cf	cmuno5h2w0008c6uvkn4m9h60	Thuckanaivkampalayam, Erode	11.5108649	77.3831231	\N	\N	2026-09-30 06:04:41.872	2026-09-30 06:04:41.872
cmuv87n9k002wc61pr8x3ypi1	bd8ff23250f3926a	\N	Angeripalayam, Tiruppur	11.1386233	77.3273283	\N	\N	2026-10-05 12:28:45.321	2026-10-05 12:28:45.321
cmu5s8c74001hc644qeqpabdw	c41cb2484ad75a4b	cmu5s6rnq001dc644odckzmfj	Gobichettipalaiyam, Erode	11.4570471	77.4385224	\N	\N	2026-09-17 17:07:09.376	2026-09-17 17:07:09.376
cmu6l17ny003ac644gtfj42ql	67d86e7ee1bc704f	\N	Salem - Thirupathur - Vaniyambadi Road, Harur, Dharmapuri	12.1780302	78.5480713	\N	\N	2026-09-18 06:33:25.772	2026-09-18 06:33:25.772
cmtmow5jn0025c6dkd8selvkd	6cffaf43ba48a6d1	\N	Sanitorium, Perundurai, Erode	11.2751142	77.5798455	\N	\N	2026-09-04 08:26:04.691	2026-09-18 09:50:59.598
cmupb9naq0010c6i7ej6abed9	52b726d0a2b1ac51	\N	Balagere, Bengaluru, Bengaluru Urban	12.9377771	77.7157283	\N	\N	2026-10-01 09:07:40.466	2026-10-01 09:07:40.466
cmtmm558y001pc6dkzsvkyo2i	5c80fc85daa1040b	cmtmoclyv0022c6dkyi415t8r	Satyamangalam, Erode	11.5031892	77.2431704	\N	\N	2026-09-04 07:09:05.362	2026-10-03 07:34:09.839
cmus310hn0031c69bctl6zzz9	a93a20c12e9d862c	\N	Udhagamandalam - Kotagiri - Mettupalayam - Sathy - Gobi - Erode Road, Gobichettipalaiyam, Erode	11.4530366	77.4506233	\N	\N	2026-10-03 07:40:19.259	2026-10-03 07:40:19.259
cmutq3b320007c61puwcxc170	517a5f41f27f79d6	\N	Kurla West, Mumbai, Mumbai Suburban	19.0605922	72.8721128	\N	\N	2026-10-04 11:13:43.646	2026-10-04 11:13:43.646
\.


--
-- Data for Name: District; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."District" (id, name, code, latitude, longitude, "isActive", "createdAt", "updatedAt") FROM stdin;
cmtns0y7d003qc6dkrd484hm1	Erode	ERO	\N	\N	t	2026-09-05 02:41:33.481	2026-09-05 02:41:33.481
\.


--
-- Data for Name: Inventory; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Inventory" (id, "productId", stock, "reorderLevel", "updatedAt") FROM stdin;
cmtqxq4gv008wc6qnl3nw2pw8	cmtqxq4gv008vc6qnxef0o0iu	2999	10	2026-09-10 16:33:27.445
cmu6bjohc001sc644co1w0q94	cmu6bjohc001rc6448ixa95ut	100	10	2026-09-21 05:47:10.435
cmu6bevpn001oc6444rl8xb58	cmu6bevpn001nc64478stpng8	100	10	2026-09-21 05:47:17.976
cmu6b9hzu001kc644gw9puddm	cmu6b9hzu001jc644ngvyav1b	100	10	2026-09-21 05:47:42.377
cmuo1cgka000gc6i7bhmu693e	cmuo1cgka000fc6i7i9bqiyoh	100	10	2026-09-30 11:42:09.371
cmuv6mjsv0023c61p7haj9xhq	cmuv6mjsv0022c61p1ahzis2h	10	10	2026-10-05 11:44:56.606
cmtoazvz3002ac6qn98dvwxem	cmtoazvz30029c6qnpt1yvwxl	99	10	2026-10-09 04:03:51.562
\.


--
-- Data for Name: MicroBanner; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."MicroBanner" (id, "districtId", title, "imageUrl", "linkUrl", "sortOrder", "isActive", "startsAt", "endsAt", "createdAt", "updatedAt") FROM stdin;
cmtpn75t20074c6qnklkvteme	\N	VMS TRADERS 	https://placehold.co/400x100	\N	0	t	\N	\N	2026-09-06 10:01:57.542	2026-09-06 10:01:57.542
\.


--
-- Data for Name: Notification; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Notification" (id, "customerId", "vendorId", type, title, body, data, "isRead", "createdAt") FROM stdin;
cmto12z870005c6qn1mqt0cqf	cmtnu3xt8003tc6dkmpc9rycj	\N	VENDOR_APPROVED	Vendor Application Approved!	Congratulations! Your shop "Madhu Forming" has been approved. Use your registered email to log in to the Vendor Panel. Check your email/SMS for temporary login details.	{"vendorId": "cmto12z7q0003c6qngfgz5u4c"}	f	2026-09-05 06:55:04.663
cmto6hp4b001kc6qnoel52dp4	cmtmrl33p0027c6dknt5h6xfq	\N	VENDOR_APPROVED	Vendor Application Approved!	Congratulations! Your shop "ZHI DIMENSIONS " has been approved. Use your registered email to log in to the Vendor Panel. Check your email/SMS for temporary login details.	{"vendorId": "cmto6hp41001ic6qnofm37rw5"}	f	2026-09-05 09:26:29.483
cmtob1ccl0032c6qnxwmarv9m	\N	cmto6hp41001ic6qnofm37rw5	PRODUCT_APPROVED	✅ Product Approved	Your product has been approved and is now visible to customers.	{"productId": "cmtoazvz30029c6qnpt1yvwxl"}	f	2026-09-05 11:33:44.516
cmtobc69n004uc6qnrat43ia3	\N	cmto6hp41001ic6qnofm37rw5	ORDER	New order received	Order ORD-1788608529839-7f803c — ₹3675	{"orderId": "cmtobc69c004qc6qnzebja8yt"}	f	2026-09-05 11:42:09.851
cmtq22342007wc6qnlamrjmy2	cmtq18z7d007cc6qnwch0now5	\N	VENDOR_APPROVED	Vendor Application Approved!	Congratulations! Your shop "THIGAZHL NALANGU MAAVU" has been approved. Use your registered email to log in to the Vendor Panel. Check your email/SMS for temporary login details.	{"vendorId": "cmtq2233s007uc6qn00o22gvp"}	f	2026-09-06 16:57:55.01
cmts5wkf7009nc6qngw5ot676	\N	cmtq2233s007uc6qn00o22gvp	PRODUCT_APPROVED	✅ Product Approved	Your product has been approved and is now visible to customers.	{"productId": "cmtqxq4gv008vc6qnxef0o0iu"}	f	2026-09-08 04:21:08.323
cmtvmksa1001rc68ck2gg68wt	cmtvlfvrl0016c68ctku1w5rk	\N	VENDOR_APPROVED	Vendor Application Approved!	Congratulations! Your shop "Auto sarvies" has been approved. Use your registered email to log in to the Vendor Panel. Check your email/SMS for temporary login details.	{"vendorId": "cmtvmks9t001pc68cu38x9lc4"}	f	2026-09-10 14:31:10.633
cmto17ygv000fc6qniq2c4k7n	cmtmmk473001yc6dk3hc8mcv2	\N	VENDOR_APPROVED	Vendor Application Approved!	Congratulations! Your shop "Jeenora" has been approved. Use your registered email to log in to the Vendor Panel. Check your email/SMS for temporary login details.	{"vendorId": "cmto17ygq000dc6qn4qn40mgu"}	t	2026-09-05 06:58:56.959
cmto1akqw0013c6qniti66bxg	\N	cmto17ygq000dc6qn4qn40mgu	ORDER	New order received	Order ORD-1788591659132-45cc14 — ₹1	{"orderId": "cmto1akql000zc6qn1ejo7ehe"}	t	2026-09-05 07:00:59.144
cmto19h8r000rc6qnvlzeof7q	\N	cmto17ygq000dc6qn4qn40mgu	PRODUCT_APPROVED	✅ Product Approved	Your product has been approved and is now visible to customers.	{"productId": "cmto1911y000lc6qnn0fgd1j2"}	t	2026-09-05 07:00:07.947
cmtvqy1ee005wc68ce31vt6h8	\N	cmtq2233s007uc6qn00o22gvp	ORDER	New order received	Order ORD-1789058007436-3adef7 — ₹84	{"orderId": "cmtvqy1e6005sc68clbx3p6pz"}	f	2026-09-10 16:33:27.447
cmtx00p2p000sc68m85jw23gk	cmtwzsg5a000kc68mg01auon4	\N	VENDOR_APPROVED	Vendor Application Approved!	Congratulations! Your shop "Iniyal boutique" has been approved. Use your registered email to log in to the Vendor Panel. Check your email/SMS for temporary login details.	{"vendorId": "cmtx00p2d000qc68m99b0r0ga"}	f	2026-09-11 13:35:14.161
cmu01cq77003sc63vp2lheige	cmu01265v003kc63vin8jkqo4	\N	VENDOR_APPROVED	Vendor Application Approved!	Congratulations! Your shop "Pet shop" has been approved. Use your registered email to log in to the Vendor Panel. Check your email/SMS for temporary login details.	{"vendorId": "cmu01cq6w003qc63v1va7veeo"}	f	2026-09-13 16:35:53.635
cmu6fagel002kc644hr9jtgl6	\N	cmto12z7q0003c6qngfgz5u4c	PRODUCT_APPROVED	✅ Product Approved	Your product has been approved and is now visible to customers.	{"productId": "cmu6b9hzu001jc644ngvyav1b"}	t	2026-09-18 03:52:39.309
cmu6faim6002mc644veo7x71s	\N	cmto12z7q0003c6qngfgz5u4c	PRODUCT_APPROVED	✅ Product Approved	Your product has been approved and is now visible to customers.	{"productId": "cmu6bevpn001nc64478stpng8"}	t	2026-09-18 03:52:42.174
cmu6faknx002oc644vjw3q8wl	\N	cmto12z7q0003c6qngfgz5u4c	PRODUCT_APPROVED	✅ Product Approved	Your product has been approved and is now visible to customers.	{"productId": "cmu6bjohc001rc6448ixa95ut"}	t	2026-09-18 03:52:44.829
cmuatrav2001oc6u6vhdspnsq	\N	cmto12z7q0003c6qngfgz5u4c	PRODUCT_APPROVED	✅ Product Approved	Your product has been approved and is now visible to customers.	{"productId": "cmu6b9hzu001jc644ngvyav1b"}	t	2026-09-21 05:48:44.606
cmuatrdnw001qc6u6cex58hpp	\N	cmto12z7q0003c6qngfgz5u4c	PRODUCT_APPROVED	✅ Product Approved	Your product has been approved and is now visible to customers.	{"productId": "cmu6bevpn001nc64478stpng8"}	t	2026-09-21 05:48:48.237
cmuatriy0001sc6u6r0zxs0gp	\N	cmto12z7q0003c6qngfgz5u4c	PRODUCT_APPROVED	✅ Product Approved	Your product has been approved and is now visible to customers.	{"productId": "cmu6bjohc001rc6448ixa95ut"}	t	2026-09-21 05:48:55.081
cmup1fu00000uc6i785mj98wk	\N	cmuo0mf4b0006c6i7c9wnekd9	PRODUCT_APPROVED	✅ Product Approved	Your product has been approved and is now visible to customers.	{"productId": "cmuo1cgka000fc6i7i9bqiyoh"}	f	2026-10-01 04:32:32.928
cmuuwy3sa000xc61phti5urag	cmuo0v8ay0009c6i7yrv0ttra	\N	VENDOR_APPROVED	Vendor Application Approved!	Congratulations! Your shop "BOOMIKA MEHANDI " has been approved. Use your registered email to log in to the Vendor Panel. Check your email/SMS for temporary login details.	{"vendorId": "cmuuwy3s4000vc61p9eb1py1a"}	t	2026-10-05 07:13:24.395
cmuv715cg002dc61p538gcch4	\N	cmuuwy3s4000vc61p9eb1py1a	PRODUCT_APPROVED	✅ Product Approved	Your product has been approved and is now visible to customers.	{"productId": "cmuv6mjsv0022c61p1ahzis2h"}	t	2026-10-05 11:55:42.545
cmv0fxd8c000nc69xs6efinou	\N	cmto6hp41001ic6qnofm37rw5	ORDER	New order received	Order ORD-1791518613548-b5e19e — ₹3675	{"orderId": "cmv0fxd7y000jc69xsrk9j66o"}	f	2026-10-09 04:03:33.564
\.


--
-- Data for Name: Offer; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Offer" (id, title, description, "imageUrl", scope, "districtId", "vendorId", "categoryId", "discountPct", "discountAmt", "minOrder", "isActive", "approvalStatus", "startsAt", "endsAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Order" (id, "orderNumber", "customerId", "vendorId", "addressId", "paymentId", status, subtotal, discount, "deliveryCharge", tax, "grandTotal", "couponCode", notes, "cancelledAt", "cancelReason", "deliveredAt", "settlementId", "createdAt", "updatedAt") FROM stdin;
cmto1akql000zc6qn1ejo7ehe	ORD-1788591659132-45cc14	cmtmmk473001yc6dk3hc8mcv2	cmto17ygq000dc6qn4qn40mgu	cmto1ah0w000wc6qn5zebnrw9	cmto1akqh000xc6qnj54cfa36	PLACED	1.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	0.050000000000000000000000000000	1.050000000000000000000000000000	\N	\N	\N	\N	\N	\N	2026-09-05 07:00:59.133	2026-09-05 07:00:59.133
cmtobc69c004qc6qnzebja8yt	ORD-1788608529839-7f803c	cmtob892m003xc6qnqhmxp8lu	cmto6hp41001ic6qnofm37rw5	cmtobc187004nc6qnp8crwz8l	cmtobc698004oc6qnskf5h0wj	PLACED	3500.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	175.000000000000000000000000000000	3675.000000000000000000000000000000	\N	\N	\N	\N	\N	\N	2026-09-05 11:42:09.841	2026-09-05 11:42:09.841
cmtvqy1e6005sc68clbx3p6pz	ORD-1789058007436-3adef7	cmtmmk473001yc6dk3hc8mcv2	cmtq2233s007uc6qn00o22gvp	cmto1ah0w000wc6qn5zebnrw9	cmtvqy1e1005qc68cr7my9u0z	PLACED	80.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	4.000000000000000000000000000000	84.000000000000000000000000000000	\N	\N	\N	\N	\N	\N	2026-09-10 16:33:27.438	2026-09-10 16:33:27.438
cmv0fxd7y000jc69xsrk9j66o	ORD-1791518613548-b5e19e	cmtnu3xt8003tc6dkmpc9rycj	cmto6hp41001ic6qnofm37rw5	cmv0fwvik000fc69xh98hbujv	cmv0fxd7r000hc69xnp0j94xd	CANCELLED	3500.000000000000000000000000000000	0.000000000000000000000000000000	0.000000000000000000000000000000	175.000000000000000000000000000000	3675.000000000000000000000000000000	\N	\N	2026-10-09 04:03:51.563	Customer cancelled	\N	\N	2026-10-09 04:03:33.55	2026-10-09 04:03:51.564
\.


--
-- Data for Name: OrderItem; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."OrderItem" (id, "orderId", "productId", name, quantity, "unitPrice", total) FROM stdin;
cmtobc69d004sc6qnv2nb1nlr	cmtobc69c004qc6qnzebja8yt	cmtoazvz30029c6qnpt1yvwxl	Steel window	1	3500.000000000000000000000000000000	3500.000000000000000000000000000000
cmtvqy1e6005uc68cu84w6o7m	cmtvqy1e6005sc68clbx3p6pz	cmtqxq4gv008vc6qnxef0o0iu	Organic nalangu maavu,	1	80.000000000000000000000000000000	80.000000000000000000000000000000
cmv0fxd7y000lc69x350lktvw	cmv0fxd7y000jc69xsrk9j66o	cmtoazvz30029c6qnpt1yvwxl	Steel window	1	3500.000000000000000000000000000000	3500.000000000000000000000000000000
\.


--
-- Data for Name: OtpSession; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."OtpSession" (id, phone, otp, "expiresAt", attempts, "createdAt") FROM stdin;
cmuqwtvux002bc69bih87ot7u	7708696683	473900	2026-10-02 12:09:02.793	0	2026-10-02 11:59:02.794
\.


--
-- Data for Name: Payment; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Payment" (id, reference, "customerId", amount, status, method, "razorpayOrderId", "razorpayPayId", "createdAt", "updatedAt") FROM stdin;
cmto1akqh000xc6qnj54cfa36	pay_7e46f72ea7f369af	cmtmmk473001yc6dk3hc8mcv2	1.050000000000000000000000000000	PENDING	COD	\N	\N	2026-09-05 07:00:59.129	2026-09-05 07:00:59.129
cmtobc698004oc6qnskf5h0wj	pay_f98316e0c5570fad	cmtob892m003xc6qnqhmxp8lu	3675.000000000000000000000000000000	PENDING	COD	\N	\N	2026-09-05 11:42:09.836	2026-09-05 11:42:09.836
cmtvqy1e1005qc68cr7my9u0z	pay_8b25ac7dff8f116a	cmtmmk473001yc6dk3hc8mcv2	84.000000000000000000000000000000	PENDING	COD	\N	\N	2026-09-10 16:33:27.434	2026-09-10 16:33:27.434
cmv0fxd7r000hc69xnp0j94xd	pay_048f52062de72e04	cmtnu3xt8003tc6dkmpc9rycj	3675.000000000000000000000000000000	PENDING	COD	\N	\N	2026-10-09 04:03:33.543	2026-10-09 04:03:33.543
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Product" (id, "vendorId", "categoryId", "subCategoryId", name, slug, description, brand, sku, barcode, mrp, "sellingPrice", unit, weight, "weightGrams", "hsnCode", "taxPct", "commissionPct", "marginPct", tags, status, "rejectionReason", "adminNotes", "isActive", "createdAt", "updatedAt") FROM stdin;
cmtoazvz30029c6qnpt1yvwxl	cmto6hp41001ic6qnofm37rw5	cmtlr6o3y0007c6su2h28ocpq	\N	Steel window	steel-window	Steel window	\N	ATM-PRXX-LZMGI0	\N	4000.000000000000000000000000000000	3500.000000000000000000000000000000	piece1	\N	\N	\N	0.000000000000000000000000000000	5.000000000000000000000000000000	0.000000000000000000000000000000	\N	PUBLISHED	\N	\N	t	2026-09-05 11:32:36.639	2026-09-05 11:33:44.515
cmtqxq4gv008vc6qnxef0o0iu	cmtq2233s007uc6qn00o22gvp	cmtlr6o3w0006c6suja1ozk3n	\N	Organic nalangu maavu,	organic-nalangu-masvu	குளியல் பொடி	\N	ATM-K0HC-LXNNYA	\N	100.000000000000000000000000000000	80.000000000000000000000000000000	100.grams	\N	\N	\N	0.000000000000000000000000000000	5.000000000000000000000000000000	0.000000000000000000000000000000	\N	PUBLISHED	\N	\N	t	2026-09-07 07:44:24.608	2026-09-08 04:21:08.319
cmuo1cgka000fc6i7i9bqiyoh	cmuo0mf4b0006c6i7c9wnekd9	cmughfcz40032c6u6spvv6qmq	\N	Nightys 	nightys	Women's night dress 	\N	ATM-AWWT-4RFPWU	\N	275.000000000000000000000000000000	275.000000000000000000000000000000	piece1	\N	\N	\N	0.000000000000000000000000000000	5.000000000000000000000000000000	0.000000000000000000000000000000	\N	PUBLISHED	\N	\N	t	2026-09-30 11:42:09.371	2026-10-01 04:32:32.925
cmu6b9hzu001jc644ngvyav1b	cmto12z7q0003c6qngfgz5u4c	cmu15y3i2000ac644afmn1lth	\N	Handmade Pink Flower Tree	handmade-pink-flower-tree	Handmade decorative tree wall art made with beautiful pink paper flowers, green grass and handcrafted details. A unique and colourful decoration for living rooms, bedrooms, kids' rooms and gifting. Each piece is carefully handmade.	\N	ATM-LXVF-DKFKB7	\N	80.000000000000000000000000000000	60.000000000000000000000000000000	piece	\N	\N	\N	0.000000000000000000000000000000	5.000000000000000000000000000000	0.000000000000000000000000000000	\N	PUBLISHED	\N	\N	t	2026-09-18 01:59:56.249	2026-09-21 05:48:44.604
cmu6bevpn001nc64478stpng8	cmto12z7q0003c6qngfgz5u4c	cmu15y3i2000ac644afmn1lth	\N	Handmade Paper Flower Wreath	handmade-paper-flower-wreath	Handmade decorative paper wreath crafted from vibrant pink and light green accordion-folded paper leaves, featuring a large pink bow and a yellow paper rose accent at the bottom. Suitable for door decor, wall hanging, festival decoration, or gifting.	\N	ATM-LXVF-HU327Q	\N	50.000000000000000000000000000000	35.000000000000000000000000000000	piece	\N	\N	\N	0.000000000000000000000000000000	5.000000000000000000000000000000	0.000000000000000000000000000000	\N	PUBLISHED	\N	\N	t	2026-09-18 02:04:07.307	2026-09-21 05:48:48.236
cmu6bjohc001rc6448ixa95ut	cmto12z7q0003c6qngfgz5u4c	cmu15y3i2000ac644afmn1lth	\N	White Feather &amp; Red Rose Paper Wreath	white-feather-amp-red-rose-paper-wreath	A handcrafted wall wreath with white fringe-cut paper feathers surrounding a ring of red roses. Perfect for lightweight, vibrant door decor or home gifting	\N	ATM-LXVF-MXHLO0	\N	50.000000000000000000000000000000	30.000000000000000000000000000000	piece	\N	\N	\N	0.000000000000000000000000000000	5.000000000000000000000000000000	0.000000000000000000000000000000	\N	PUBLISHED	\N	\N	t	2026-09-18 02:07:51.216	2026-09-21 05:48:55.079
cmuv6mjsv0022c61p1ahzis2h	cmuuwy3s4000vc61p9eb1py1a	cmtlr6o3w0006c6suja1ozk3n	\N	Bridal Mehandi 	bridal-mehandi	Mehandi For All Occasions 	\N	ATM-14C2-1TPA5R	\N	1000.000000000000000000000000000000	1200.000000000000000000000000000000	piece	\N	\N	\N	0.000000000000000000000000000000	5.000000000000000000000000000000	0.000000000000000000000000000000	\N	PUBLISHED	\N	\N	t	2026-10-05 11:44:21.44	2026-10-05 11:55:42.543
\.


--
-- Data for Name: ProductApproval; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."ProductApproval" (id, "productId", "vendorId", status, "adminNotes", "rejectionReason", "reviewedBy", "reviewedAt", "createdAt", "updatedAt") FROM stdin;
cmtob0zfu0030c6qny3fadlpf	cmtoazvz30029c6qnpt1yvwxl	cmto6hp41001ic6qnofm37rw5	APPROVED	\N	\N	cmtlr19vc0000c695n8dulqfn	2026-09-05 11:33:44.512	2026-09-05 11:33:27.785	2026-09-05 11:33:44.513
cmtqxqcyh008yc6qna4n1s11w	cmtqxq4gv008vc6qnxef0o0iu	cmtq2233s007uc6qn00o22gvp	APPROVED	\N	\N	cmtlr19vc0000c695n8dulqfn	2026-09-08 04:21:08.313	2026-09-07 07:44:35.609	2026-09-08 04:21:08.314
cmu6f8rc1002hc64466d6ek2v	cmu6b9hzu001jc644ngvyav1b	cmto12z7q0003c6qngfgz5u4c	APPROVED	\N	\N	cmtlr19vc0000c695n8dulqfn	2026-09-21 05:48:44.603	2026-09-18 03:51:20.162	2026-09-21 05:48:44.603
cmu6f8qaz002fc6444ahq34az	cmu6bevpn001nc64478stpng8	cmto12z7q0003c6qngfgz5u4c	APPROVED	\N	\N	cmtlr19vc0000c695n8dulqfn	2026-09-21 05:48:48.234	2026-09-18 03:51:18.828	2026-09-21 05:48:48.235
cmu6f8p3d002dc644t0194s84	cmu6bjohc001rc6448ixa95ut	cmto12z7q0003c6qngfgz5u4c	APPROVED	\N	\N	cmtlr19vc0000c695n8dulqfn	2026-09-21 05:48:55.077	2026-09-18 03:51:17.257	2026-09-21 05:48:55.078
cmuo1ckxc000jc6i7oupamejo	cmuo1cgka000fc6i7i9bqiyoh	cmuo0mf4b0006c6i7c9wnekd9	APPROVED	\N	\N	cmtlr19vc0000c695n8dulqfn	2026-10-01 04:32:32.917	2026-09-30 11:42:15.025	2026-10-01 04:32:32.918
cmuv6mnmb0025c61pcjx4r10n	cmuv6mjsv0022c61p1ahzis2h	cmuuwy3s4000vc61p9eb1py1a	APPROVED	\N	\N	cmtlr19vc0000c695n8dulqfn	2026-10-05 11:55:42.541	2026-10-05 11:44:26.388	2026-10-05 11:55:42.542
\.


--
-- Data for Name: ProductImage; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."ProductImage" (id, "productId", url, "publicId", "sortOrder", "isPrimary", "createdAt") FROM stdin;
cmtoazvz3002bc6qnopjugju7	cmtoazvz30029c6qnpt1yvwxl	https://api.alltimemarket.in/uploads/all-time-market/districtmart/products/c0523ee9-54ef-4565-bf78-643abaab8bd9.webp	\N	0	t	2026-09-05 11:32:36.639
cmuatpa7b001fc6u6ghucre3g	cmu6bjohc001rc6448ixa95ut	https://api.alltimemarket.in/uploads/all-time-market/districtmart/products/f60c92f5-44e3-404d-8ef7-b5b74a05b7b5.webp	\N	0	t	2026-09-21 05:47:10.439
cmuatpg0t001ic6u6dou3zpyv	cmu6bevpn001nc64478stpng8	https://api.alltimemarket.in/uploads/all-time-market/districtmart/products/b00f0b7c-e89d-4315-8141-597ab606035e.webp	\N	0	t	2026-09-21 05:47:17.982
cmuatpyuk001lc6u6kdsxp7d9	cmu6b9hzu001jc644ngvyav1b	https://api.alltimemarket.in/uploads/all-time-market/districtmart/products/d64ccc81-d84c-4902-85fb-2f208e204d7f.webp	\N	0	t	2026-09-21 05:47:42.38
cmuo1cgka000hc6i79e8wq20t	cmuo1cgka000fc6i7i9bqiyoh	https://api.alltimemarket.in/uploads/all-time-market/districtmart/products/4183162c-f9c8-4e03-8d52-d44a83d23e5c.webp	\N	0	t	2026-09-30 11:42:09.371
\.


--
-- Data for Name: RefreshToken; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."RefreshToken" (id, token, "userId", "userRole", "expiresAt", "deviceName", "deviceId", "deviceModel", "osVersion", "ipAddress", "createdAt") FROM stdin;
cmtlr25vg001nc6dkwpua31hq	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4NDUzNTM4LCJleHAiOjE3ODkwNTgzMzh9.9lqYUs9Aqp3cgLTo1HWuzFlcUEvVmd-_kL9tQf88PbM	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-10 16:38:58.107	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	\N	\N	\N	162.159.99.64	2026-09-03 16:38:58.108
cmtmmargk001qc6dk7fv7b1qp	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4NTA2MDA3LCJleHAiOjE3ODkxMTA4MDd9.EY2aCebbhe-7aocr6vxh6k4GFtyzx8AJHnnB8btjptA	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-11 07:13:27.427	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	162.158.88.139	2026-09-04 07:13:27.428
cmtmmk47z0020c6dkn8bzozta	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NTA2NDQzLCJleHAiOjE3ODkxMTEyNDN9.ny1dNpwlUrni1mT5EQ--tiNsxdpTg60GI3gIddvc0wA	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-11 07:20:43.87	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.23.168.32	2026-09-04 07:20:43.871
cmtmrl3460029c6dk2jmsjwyg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NTE0ODg3LCJleHAiOjE3ODkxMTk2ODd9.6PqNtesuDFZoBq1RqywDWivGzWTHNB3O4L-48TR6iB8	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-11 09:41:27.172	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	172.68.55.202	2026-09-04 09:41:27.175
cmtnu3xty003vc6dk8at1pty8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NTc5NTkyLCJleHAiOjE3ODkxODQzOTJ9.Ga9A57fezR4OM0VUCR89C8ROtNT_1JJmeUUZ9KLVaB8	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-12 03:39:52.197	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-05 03:39:52.198
cmtnxw1yr0048c6dkyzqhwubm	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NTg1OTQyLCJleHAiOjE3ODkxOTA3NDJ9.BBNo-jrLn9i45g-zkCuwKnX2gU-6L9KxwtDCXts5bhw	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-12 05:25:42.77	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	172.70.108.110	2026-09-05 05:25:42.771
cmtnxwatx0049c6dkgqqudifu	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NTg1OTU0LCJleHAiOjE3ODkxOTA3NTR9.MADw0Q4s7YnFLymIngKkay6lLlNtWBab6FAy5Sy-Fwc	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-12 05:25:54.261	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	172.70.108.110	2026-09-05 05:25:54.262
cmtnzfhkp004dc6dkyxh6en9r	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4NTg4NTI5LCJleHAiOjE3ODkxOTMzMjl9.DIMdGyR7F-NPh2t5ofZUvmriaLX69PBAt4--c7tMg2s	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-12 06:08:49.081	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	104.23.175.69	2026-09-05 06:08:49.082
cmto1355m0006c6qnsefz4ny7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODU5MTMxMiwiZXhwIjoxNzg5MTk2MTEyfQ.XVi1Amx5rTZey6Qbf0t9h7me5F2BRuL4Xf5aTgPOoc8	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-12 06:55:12.345	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	172.68.234.130	2026-09-05 06:55:12.346
cmto137ee0007c6qn8qgowe8w	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NTkxMzE1LCJleHAiOjE3ODkxOTYxMTV9.AkF6CWpIT2dAy4wFLS9s8o3l51QyMNqdi7aMBEYUdl0	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-12 06:55:15.253	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	172.68.234.130	2026-09-05 06:55:15.254
cmto13ivx0008c6qnf463nu3b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODU5MTMzMCwiZXhwIjoxNzg5MTk2MTMwfQ.XHpzp5b3GY2rXndvU9mowDUNQCEjnaJw59HcjwqO944	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-12 06:55:30.14	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	172.68.234.130	2026-09-05 06:55:30.141
cmto13p8g0009c6qnszpq7ink	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NTkxMzM4LCJleHAiOjE3ODkxOTYxMzh9.I4Vcm4dkzwXIIhPJX-wJSRn5NvQysQxZR1H898oX_y8	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-12 06:55:38.368	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-05 06:55:38.368
cmto1814z000gc6qnw6mtdax0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODU5MTU0MCwiZXhwIjoxNzg5MTk2MzQwfQ.DI_NEQUu2961HMqi06FL_CDNlCmfA4gfNNF9JtjV3Pw	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-12 06:59:00.415	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-05 06:59:00.42
cmto181nd000hc6qnqn8g12e4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODU5MTU0MSwiZXhwIjoxNzg5MTk2MzQxfQ.RLWaJgaESXXZeI0gzXuuJAkpqkHY101tZWXKeAKLwn4	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-12 06:59:01.08	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-05 06:59:01.081
cmto184le000ic6qnp1b1khd7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NTkxNTQ0LCJleHAiOjE3ODkxOTYzNDR9.pnk3GWsSdxAvuZztJObUsnUMqrlhwplBJDRpZ--vXIw	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-12 06:59:04.898	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-05 06:59:04.898
cmto1871o000jc6qnopw8ebx1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODU5MTU0OCwiZXhwIjoxNzg5MTk2MzQ4fQ.zmuWSUkxPcWdGY8wOjbiBGAsQXVwK2gp1dL8DY200UE	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-12 06:59:08.076	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-05 06:59:08.077
cmto19nc2000sc6qn0w4qkcqo	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NTkxNjE1LCJleHAiOjE3ODkxOTY0MTV9.gRqohcrnq-svrgc5lY6zYq31E3Q8x-DSdJurMJ6e57w	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-12 07:00:15.841	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-05 07:00:15.842
cmto1mhu80015c6qn114iim15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4NTkyMjE1LCJleHAiOjE3ODkxOTcwMTV9.FGcoMngF7PsHcF_vsQ3FT75-cCosCsMb5j2lLVI376Q	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-12 07:10:15.248	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	162.158.170.24	2026-09-05 07:10:15.248
cmto5obwe0016c6qnc7oplggn	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4NTk5MDE5LCJleHAiOjE3ODkyMDM4MTl9.jP8OjpHFBj-CU93nr5HtHF1K7MonCJjgScvqnQWSIus	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-12 09:03:39.324	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	162.158.108.158	2026-09-05 09:03:39.326
cmto6f9lv001fc6qni62qmcbz	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4NjAwMjc2LCJleHAiOjE3ODkyMDUwNzZ9.0CWLLIDf-ldy426uMMRnP_OM4q6m7FdrNRYWdmsF0LM	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-12 09:24:36.066	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	162.158.162.74	2026-09-05 09:24:36.067
cmto6hcp3001gc6qnzw07jmjy	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjAwMzczLCJleHAiOjE3ODkyMDUxNzN9.ENCSd48OL7R6OwZBX_3iZW0umjeQdb87eHxJxphICvc	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-12 09:26:13.383	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.99.181	2026-09-05 09:26:13.384
cmto8foqs001lc6qnlss6qxww	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODYwMzY1NCwiZXhwIjoxNzg5MjA4NDU0fQ.FNUUxPjfNfKzm4lU3zw76wUGgjjzw7VtO7yL9oBWWmU	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-12 10:20:54.916	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.95.102	2026-09-05 10:20:54.917
cmto8ftqt001mc6qnjci077dq	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjAzNjYxLCJleHAiOjE3ODkyMDg0NjF9.sQtpy54ncb8cVdSoTDKsNCG6GXXLWVCI5wBTf0190Oc	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-12 10:21:01.397	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.95.102	2026-09-05 10:21:01.397
cmto8fvyj001nc6qn7tevm6im	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODYwMzY2NCwiZXhwIjoxNzg5MjA4NDY0fQ.vi2NBkHocHh7_Q9uac8kP_EKMJzMyqZAVjy_U5gH5Kk	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-12 10:21:04.267	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.95.102	2026-09-05 10:21:04.268
cmto8g25f001oc6qnyl1ru8h7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjAzNjcyLCJleHAiOjE3ODkyMDg0NzJ9.bED_JgOqYiqcf6GnXoPDqf2-hLHlJ6J7ES1L8L9z-io	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-12 10:21:12.291	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.95.102	2026-09-05 10:21:12.292
cmto8g9el001pc6qn6cdcksdw	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODYwMzY4MSwiZXhwIjoxNzg5MjA4NDgxfQ.fnkdQpLqlocPBeTHq3UgIowWdYejop1n7dXYSTnqI1U	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-12 10:21:21.692	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.95.102	2026-09-05 10:21:21.693
cmto8gay1001qc6qns0gjfraf	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjAzNjgzLCJleHAiOjE3ODkyMDg0ODN9.JqmWSS20ZdrFyPFa7vqjiiVyDjuqMHMsJhL15uYtTm0	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-12 10:21:23.689	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.95.102	2026-09-05 10:21:23.69
cmtoats5c001uc6qnmxks1joc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjA3NjcxLCJleHAiOjE3ODkyMTI0NzF9.ht5e6e0zg5p6RvKW6__0kXHX_87OMw83FsVrIGSz2N4	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-12 11:27:51.744	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	104.22.14.112	2026-09-05 11:27:51.745
cmtoau4zu001vc6qnvjn7r7gx	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODYwNzY4OCwiZXhwIjoxNzg5MjEyNDg4fQ.fhtgIvlOzXLeZ_5bWkHp91EcnKdieBe28xXm5_I3ezo	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-12 11:28:08.393	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	104.22.14.112	2026-09-05 11:28:08.394
cmtoauqft001wc6qn2wxb99z0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjA3NzE2LCJleHAiOjE3ODkyMTI1MTZ9.xyLgT2Pu9knmmcQfq38P6iayBKiyR4UfKlTxAveJsdc	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-12 11:28:36.185	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	104.22.14.112	2026-09-05 11:28:36.186
cmtoaxuxk0027c6qnlmmy2tmx	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODYwNzg2MSwiZXhwIjoxNzg5MjEyNjYxfQ.5mTvAmDItGErs0H65zPlL2huKdb3oZ74r39c3_3iEsU	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-12 11:31:01.976	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	104.22.14.112	2026-09-05 11:31:01.976
cmtob06ui002cc6qnv5nk5pd5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjA3OTcwLCJleHAiOjE3ODkyMTI3NzB9.w-jj-BEaEL_eNfmo6c0FWtmM4v5hyg8c5r7wP0g_gL0	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-12 11:32:50.729	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	104.22.14.112	2026-09-05 11:32:50.73
cmtob0eqy002hc6qnrcxctzvg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4NjA3OTgwLCJleHAiOjE3ODkyMTI3ODB9.qKnvZxHqeHARY8Pv8dObrueGCy5VXpm_0nP2b2MB7g4	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-12 11:33:00.969	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	108.162.226.103	2026-09-05 11:33:00.97
cmtob0tln002yc6qnx96gvood	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODYwODAwMCwiZXhwIjoxNzg5MjEyODAwfQ.ZYqZHF1a0CyTuJcUMM63n-AUHL--nfF1ArK3lXgyghg	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-12 11:33:20.219	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	104.22.14.112	2026-09-05 11:33:20.22
cmtob1m6e0033c6qnjknhv144	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjA4MDM3LCJleHAiOjE3ODkyMTI4Mzd9.W9zUluMRXSQA6dQ7L431Y54sEiby-I3TnzsOWOEWGO4	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-12 11:33:57.253	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	104.22.14.112	2026-09-05 11:33:57.254
cmtob8930003zc6qnrevou7h2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvYjg5Mm0wMDN4YzZxbnFobXhwOGx1Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjA4MzQ2LCJleHAiOjE3ODkyMTMxNDZ9.h3p56Xs3AzYZUNOmMuVtUlBE5DitFEa1F99bE0HqNjg	cmtob892m003xc6qnqhmxp8lu	CUSTOMER	2026-09-12 11:39:06.875	okhttp/4.12.0	3d3d24c34f733e48	V2545	16	104.22.176.5	2026-09-05 11:39:06.876
cmtobco9t004vc6qnzqc4rx02	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODYwODU1MywiZXhwIjoxNzg5MjEzMzUzfQ.eu2Mb3-Z9qOs83_xa0JjdkHJVZGQ4NeRWtc76K36-mU	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-12 11:42:33.184	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	172.68.55.202	2026-09-05 11:42:33.185
cmtodczwa005wc6qnbeveieok	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODYxMTkyNywiZXhwIjoxNzg5MjE2NzI3fQ.ptl5E1xpl-8JSQWeNRKv_YIc-vLuYvKeZH7JJeNc62Y	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-12 12:38:47.482	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.68.55.202	2026-09-05 12:38:47.483
cmtodlbns005xc6qn6kpl5wpy	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjEyMzE1LCJleHAiOjE3ODkyMTcxMTV9.rRcuvqG0P9zPM3vKx0j0jrAQgjIWVzYIqXrNjIDMfuo	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-12 12:45:15.976	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.23.172.61	2026-09-05 12:45:15.977
cmtoecesr0062c6qncprrjdnq	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjEzNTc5LCJleHAiOjE3ODkyMTgzNzl9.YeFpeSDRSpdaBXk24UR-FBW-H7PR9YAkEFQrR7P1LrI	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-12 13:06:19.755	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.159.113.80	2026-09-05 13:06:19.756
cmtoecgsp0063c6qn9vwsa4sj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODYxMzU4MiwiZXhwIjoxNzg5MjE4MzgyfQ.BY4NQBy9_AF0DyoFIcjBttwGtS2DYNHNQxbYrc89cnY	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-12 13:06:22.344	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.159.113.35	2026-09-05 13:06:22.345
cmtoecioz0064c6qnfzbl6d4c	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjEzNTg0LCJleHAiOjE3ODkyMTgzODR9._P8LzE40ILJdKGfjkzFyGTIFrLF9YdJ-XzgZs8hPocM	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-12 13:06:24.802	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.159.113.35	2026-09-05 13:06:24.803
cmtoieuvj006cc6qn3eojijek	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvaWV1djIwMDZhYzZxbnI0MDFzNW51Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjIwNDEyLCJleHAiOjE3ODkyMjUyMTJ9.6D-1VBJrA8TKLb1I4CySZsM5jY0fd7OJv3bGrACLa2c	cmtoieuv2006ac6qnr401s5nu	CUSTOMER	2026-09-12 15:00:12.362	okhttp/4.12.0	50c0ac913103af44	V2031	13	172.68.55.202	2026-09-05 15:00:12.363
cmtpa491u006xc6qn06s5e03i	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4NjY2OTQ2LCJleHAiOjE3ODkyNzE3NDZ9.Fdy86x7xf54k_t6knkMAaEDGZUo8doiv6eZC4442OLw	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-13 03:55:46.768	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	104.22.14.146	2026-09-06 03:55:46.77
cmtpdn15t0071c6qnn454gy02	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRwZG4xNWQwMDZ6YzZxbjV5d3NzZW5kIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjcyODYxLCJleHAiOjE3ODkyNzc2NjF9.HSxj6gjoM68zJdBD04Cvjp0901j1n0NSuRBBwUQva7I	cmtpdn15d006zc6qn5ywssend	CUSTOMER	2026-09-13 05:34:21.857	okhttp/4.12.0	c71be8b2327c9223	V2515	16	162.158.235.125	2026-09-06 05:34:21.857
cmtpdo2kj0072c6qnla18e3uh	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRwZG4xNWQwMDZ6YzZxbjV5d3NzZW5kIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NjcyOTEwLCJleHAiOjE3ODkyNzc3MTB9.mtFXaVrgFYgyNw1eOIECXEjAavzeGBv-CWjfUwaSC8Y	cmtpdn15d006zc6qn5ywssend	CUSTOMER	2026-09-13 05:35:10.339	okhttp/4.12.0	c71be8b2327c9223	V2515	16	162.158.235.125	2026-09-06 05:35:10.339
cmtpn05sg0073c6qn28q4dnar	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4Njg4NTkwLCJleHAiOjE3ODkyOTMzOTB9.OwA8G7JTxc50VAVgKBkXJEzOdyW8G_NOx96l133X_50	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-13 09:56:30.927	Mozilla/5.0 (Linux; Android 15; V2303) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/16.3.1.0	\N	\N	\N	104.22.14.112	2026-09-06 09:56:30.928
cmtq10ci60077c6qn9ethesfa	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4NzEyMTE0LCJleHAiOjE3ODkzMTY5MTR9.sQ7mhjQ9WY-_Npb5uoMYow9fvF0VPZx08QMLvxDKeuY	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-13 16:28:34.252	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	172.70.142.3	2026-09-06 16:28:34.254
cmtq13eww007ac6qnc7ynt93q	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRxMTNld2gwMDc4YzZxbnYwY2x1aGZlIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NzEyMjU3LCJleHAiOjE3ODkzMTcwNTd9.90vCWt3Tnryl1x9JntOq_NXRqrA_hcSjNnFRX-Ae2RU	cmtq13ewh0078c6qnv0cluhfe	CUSTOMER	2026-09-13 16:30:57.344	okhttp/4.12.0	84dce353e9680019	RMX2156	12	104.22.14.112	2026-09-06 16:30:57.345
cmtq18z7j007ec6qnzdvk8xc2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRxMTh6N2QwMDdjYzZxbndjaDBub3c1Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NzEyNTE2LCJleHAiOjE3ODkzMTczMTZ9.f1KYVHDFDS9nU36viJeUU9MppOg8Zf077HlKuethfIE	cmtq18z7d007cc6qnwch0now5	CUSTOMER	2026-09-13 16:35:16.927	okhttp/4.12.0	a75d1641b520690f	TECNO KE6j	10	172.68.55.202	2026-09-06 16:35:16.928
cmtqxh2yj008kc6qnryiiv97o	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRxeGgyeTQwMDhpYzZxbmdzeXlnZWUwIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NzY2NjQyLCJleHAiOjE3ODkzNzE0NDJ9.0vAN8jo7N8Ys7GdNuPlO8Ec-3hbGwRgpEjtLJx_Cnec	cmtqxh2y4008ic6qngsyygee0	CUSTOMER	2026-09-14 07:37:22.746	okhttp/4.12.0	d9a9c77d02e56fce	RMX5250	15	172.70.93.109	2026-09-07 07:37:22.747
cmtqxjbam008tc6qnu3jcm0xl	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRxMjIzM3MwMDd1YzZxbjAwbzIyZ3ZwIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODc2Njc0NiwiZXhwIjoxNzg5MzcxNTQ2fQ.28yUON2H49X1PV2XEyMbczd9MdYVPsMN6Cc0fHdRjv4	cmtq2233s007uc6qn00o22gvp	VENDOR	2026-09-14 07:39:06.861	okhttp/4.12.0	a75d1641b520690f	TECNO KE6j	10	172.71.152.26	2026-09-07 07:39:06.862
cmtqydaha0099c6qnn8p24d21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRxeWRhZ3cwMDk3YzZxbmgwbmM3ZXFrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4NzY4MTQ1LCJleHAiOjE3ODkzNzI5NDV9.YuZgRxIdCNM_-mdx1iVBy5ceHVS8xeuNyc7AGk0i-Fs	cmtqydagw0097c6qnh0nc7eqk	CUSTOMER	2026-09-14 08:02:25.486	okhttp/4.12.0	10040471cfa3a4df	CPH2717	16	172.71.95.102	2026-09-07 08:02:25.487
cmtrdhrio009ec6qnp6sr1wap	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODc5MzU0OCwiZXhwIjoxNzg5Mzk4MzQ4fQ.EbUVRkRIRdZWKIVbssUY4nFggZu3kiy-AU7Tu1XvOnQ	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-14 15:05:48.431	okhttp/4.12.0	211a141fbd5b2945	V2511	16	162.159.113.35	2026-09-07 15:05:48.432
cmtrdvcjw009fc6qnly0k4ra4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4Nzk0MTgyLCJleHAiOjE3ODkzOTg5ODJ9.YMj_S7GHbkNWW2LoxFtvMYbGXp6QXSy8CQO9pv033M0	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-14 15:16:22.22	okhttp/4.12.0	211a141fbd5b2945	V2511	16	172.71.103.203	2026-09-07 15:16:22.221
cmtrdvkub009gc6qnj0jciw5f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODc5NDE5MiwiZXhwIjoxNzg5Mzk4OTkyfQ.Muzi5mWQ08g7dT4tTPZ5KRhLR9lmLCaPYqw-gRmJohs	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-14 15:16:32.96	okhttp/4.12.0	211a141fbd5b2945	V2511	16	172.71.102.43	2026-09-07 15:16:32.961
cmtrdvmz9009hc6qn2oik63x9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4Nzk0MTk1LCJleHAiOjE3ODkzOTg5OTV9.gXsoVY-ffnoFCJSb_bVivCWq4MfnZh_3Yf91vQ9uVcc	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-14 15:16:35.733	okhttp/4.12.0	211a141fbd5b2945	V2511	16	172.71.102.43	2026-09-07 15:16:35.734
cmtrfp1cn009ic6qnbnag9w9v	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4Nzk3MjQ2LCJleHAiOjE3ODk0MDIwNDZ9.AR9SYC6zEf5Gspk2WhLN3LRkB85hY9HFXC-VKqrJeig	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-14 16:07:26.999	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	\N	\N	\N	172.68.55.202	2026-09-07 16:07:27
cmtrfq4rv009jc6qneuzj4ldj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODc5NzI5OCwiZXhwIjoxNzg5NDAyMDk4fQ.LIG_T7HwfvFLa0CA0tu2HFqeGbjG2N_FcSb3Cmq5etY	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-14 16:08:18.091	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.22.14.112	2026-09-07 16:08:18.092
cmtrfq89c009kc6qnta8qrosk	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4Nzk3MzAyLCJleHAiOjE3ODk0MDIxMDJ9.wXS5-edqJkIQVsnV_VGusjy38UfrjyvXO5yPhJbIceA	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-14 16:08:22.608	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.22.14.112	2026-09-07 16:08:22.609
cmts5vwjj009lc6qnbph97qtr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4ODQxMjM3LCJleHAiOjE3ODk0NDYwMzd9.qGHDNcuaMDlfpNQzKggf_KlgljPiItoCdx4OzUygbI4	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-15 04:20:37.374	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	162.158.88.139	2026-09-08 04:20:37.375
cmtswsoe2009oc6qn3dgr392i	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODg4NjQzNiwiZXhwIjoxNzg5NDkxMjM2fQ.E6_SEf0qZtFOn8WHBDe287L6TV03cLqNe1Vb3Z_u_RI	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-15 16:53:56.473	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.170.33	2026-09-08 16:53:56.474
cmtswsre7009pc6qntezt0g0f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4ODg2NDQwLCJleHAiOjE3ODk0OTEyNDB9.XfsfYBiKYGH5DP27yw7AoeOooiJzKBg97LIiX76ZUuw	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-15 16:54:00.366	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.170.33	2026-09-08 16:54:00.367
cmttmk8zm0006c60pzbotj3kr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4OTI5NzEzLCJleHAiOjE3ODk1MzQ1MTN9.egnkQn2jQq8nQopqmJigafFjxEPHTSXARpjgqlJsGX4	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-16 04:55:13.282	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	162.158.108.159	2026-09-09 04:55:13.283
cmtto62k50012c60ppl0k45ig	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODkzMjQxMCwiZXhwIjoxNzg5NTM3MjEwfQ.7uP3pdR-AeFymZddwRJjsk4vZfLgT--WtQAyj00k4FY	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-16 05:40:10.997	okhttp/4.12.0	37c0c246503697b8	V2511	16	162.159.113.81	2026-09-09 05:40:10.997
cmtto64vv0013c60pnndt18ta	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4OTMyNDE0LCJleHAiOjE3ODk1MzcyMTR9.dNV-2gnPvaaR6pHGvojoychfZjPLycxtLKW1vJt2Xbc	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-16 05:40:14.011	okhttp/4.12.0	37c0c246503697b8	V2511	16	162.159.113.81	2026-09-09 05:40:14.012
cmtto68ix0014c60pufcaccir	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODkzMjQxOCwiZXhwIjoxNzg5NTM3MjE4fQ.sTzia_Zy47rIbcm8Yts-MX0oWvcG5R0wrO6M4QR4AOE	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-16 05:40:18.729	okhttp/4.12.0	37c0c246503697b8	V2511	16	162.159.113.34	2026-09-09 05:40:18.729
cmttodkdo0016c60p3vtfcys6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4OTMyNzYwLCJleHAiOjE3ODk1Mzc1NjB9.beJjusOB_XrGkHnHMaQRuasBYVG4Lq5Btbx-b-xTrw0	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-16 05:46:00.684	okhttp/4.12.0	37c0c246503697b8	V2511	16	162.159.113.34	2026-09-09 05:46:00.685
cmttodnhg0017c60pqsg03no6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODkzMjc2NCwiZXhwIjoxNzg5NTM3NTY0fQ.HmMaSNFx-mivh8zZeFZuVKHGLLJhqEl_oU2v471PY3w	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-16 05:46:04.708	okhttp/4.12.0	37c0c246503697b8	V2511	16	162.159.113.34	2026-09-09 05:46:04.709
cmttodsu30018c60p2jjx5vxl	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4OTMyNzcxLCJleHAiOjE3ODk1Mzc1NzF9.5sxvzJmbBFhmXvpdzYQz0E1KmUeZ3m_qp2jq9yI3uX4	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-16 05:46:11.643	okhttp/4.12.0	37c0c246503697b8	V2511	16	162.159.113.35	2026-09-09 05:46:11.644
cmttqg8lq0019c60pgyfzk1gr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4OTM2MjQ0LCJleHAiOjE3ODk1NDEwNDR9.ew4N4xKM3hrHx5nGxtgNQkLiLRJZ0jbGk0ZgNImI0bI	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-16 06:44:04.621	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	162.159.98.126	2026-09-09 06:44:04.623
cmttrvqky0001c68clck092kq	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg4OTM4NjQ3LCJleHAiOjE3ODk1NDM0NDd9.lJFkAqYlwIMTl1BzHPqQ4X28YJe_ORPn1FyLXyo1Y14	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-16 07:24:07.377	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	104.23.175.66	2026-09-09 07:24:07.378
cmttrxc6e0002c68cvbjri8yj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4OTM4NzIyLCJleHAiOjE3ODk1NDM1MjJ9.qqi4HgCYnqx1YpXV6EPwQrEf2Ha9wigXrnb9sA2Coe4	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-16 07:25:22.021	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-09 07:25:22.022
cmttrxg2g0003c68cq5zlgd8l	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODkzODcyNywiZXhwIjoxNzg5NTQzNTI3fQ.VVb0gaYKGoND-LLwSzPxfwk_VpcgN0bKuLzijPJwdZc	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-16 07:25:27.064	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-09 07:25:27.065
cmttsd3070004c68cecey79d5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4OTM5NDU2LCJleHAiOjE3ODk1NDQyNTZ9.klInhlDKaq3AnlZGI0TwnomS4hjvDbrRAZrWXfaMI90	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-16 07:37:36.63	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-09 07:37:36.632
cmttuvfk00005c68cun7u2hcx	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4OTQzNjcxLCJleHAiOjE3ODk1NDg0NzF9.JTtXFEusDC3ec6xdmEGRL2Lzkm2vt2-_p1CJNug3jNE	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-16 08:47:51.935	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	162.159.113.35	2026-09-09 08:47:51.936
cmttuvmiq0006c68cbipdws0b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODk0MzY4MCwiZXhwIjoxNzg5NTQ4NDgwfQ.CuI1ubiCFOy_bTKWOF7PdJe1Mi-19cN8AsalPdQnEV4	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-16 08:48:00.96	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	162.159.113.35	2026-09-09 08:48:00.962
cmtu5f46p0007c68c5iwweo9r	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg4OTYxMzg2LCJleHAiOjE3ODk1NjYxODZ9.X0W_VDujlQdFHBO-cJZlEDkQGvynIhMcexrAKEWPw8o	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-16 13:43:06.479	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	172.68.55.202	2026-09-09 13:43:06.481
cmtu5fg6e0008c68cqmfdbgl5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4ODk2MTQwMiwiZXhwIjoxNzg5NTY2MjAyfQ.GEx74Hnxlldb1SKTXaQgTfcci7mB3muzaFcHk1Wy4Mw	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-16 13:43:22.022	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	172.68.55.202	2026-09-09 13:43:22.023
cmtv8s34f000jc68c7ul5z94l	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTAyNzQ5NiwiZXhwIjoxNzg5NjMyMjk2fQ.2-Vm5wPmkzDZqSrEb7XlIbxtNQkhFIiMmuYoVMxb7Yo	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 08:04:56.655	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.68.55.202	2026-09-10 08:04:56.656
cmtvdghsi000lc68ckl4j4tis	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTAzNTM1MywiZXhwIjoxNzg5NjQwMTUzfQ.OPbIm-YlSbkN2boPqOyqljy6dZrlDFkbFaw1i_Ev4Fo	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-17 10:15:53.873	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.170.32	2026-09-10 10:15:53.874
cmtvdh14t000mc68c14kcwal3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDM1Mzc4LCJleHAiOjE3ODk2NDAxNzh9.OpfVvZVfWjy7PDLGDU65mVDqPwSW10O8EJ0_jTgEYtg	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-17 10:16:18.937	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.170.33	2026-09-10 10:16:18.941
cmtvdh4yd000nc68cpqej0dan	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTAzNTM4MywiZXhwIjoxNzg5NjQwMTgzfQ.3Dp6H3YLrJoXX3Wj4lMzwp15cS1XYYq1UpvzNfqg9WI	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-17 10:16:23.892	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.170.32	2026-09-10 10:16:23.893
cmtvdh7ui000oc68cjf8nyi7f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDM1Mzg3LCJleHAiOjE3ODk2NDAxODd9.DUJ2LoyEry2JxX4K4JvMHQsMdmjGvqBVOi0iRKcoRyA	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-17 10:16:27.641	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.170.32	2026-09-10 10:16:27.642
cmtvhzg1k000vc68cxzduqvok	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA0Mjk1NiwiZXhwIjoxNzg5NjQ3NzU2fQ.N8QJL1OViyWMjEgYO5jMBoEuMPMm08gimP92U9iVzfQ	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-17 12:22:36.534	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	141.101.76.54	2026-09-10 12:22:36.536
cmtvhzs0u000wc68ccssm97fh	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA0Mjk3MiwiZXhwIjoxNzg5NjQ3NzcyfQ.6hZveoJjeUt1vGod3wEDKrXeoOziDWSH-lQ4TF6BzhU	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-17 12:22:52.061	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	141.101.76.54	2026-09-10 12:22:52.062
cmtvhzykp000xc68cfyx4ls55	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA0Mjk4MCwiZXhwIjoxNzg5NjQ3NzgwfQ.87onpslULdN_rdOE4DZQ_lcvGohrtPlXN0A3LtVyefo	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-17 12:23:00.551	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	141.101.76.54	2026-09-10 12:23:00.553
cmtvhzz37000zc68ceh2rtg5v	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA0Mjk4MSwiZXhwIjoxNzg5NjQ3NzgxfQ.fq35KuK7EDvZlDe8NeRv1mzSxc3ScstqlvuXZwBKiiE	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-17 12:23:01.219	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	141.101.76.54	2026-09-10 12:23:01.22
cmtvi03fy0014c68csoelojik	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDQyOTg2LCJleHAiOjE3ODk2NDc3ODZ9.Iy7F28bdlN9Nqe-DuMvqb7KDX4kY-kFfnFkoSQNmH6M	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-17 12:23:06.861	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	141.101.76.54	2026-09-10 12:23:06.862
cmtvi0ak20015c68cy8w0yi7f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA0Mjk5NiwiZXhwIjoxNzg5NjQ3Nzk2fQ.frcEVELUckAcgbn_G7C9BW4jjkuV3b_49tVUJRElyn0	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-17 12:23:16.081	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	141.101.76.55	2026-09-10 12:23:16.082
cmtvlfvs00018c68c75enpbqc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bGZ2cmwwMDE2YzY4Y3RrdTF3NXJrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDQ4NzYyLCJleHAiOjE3ODk2NTM1NjJ9.5XRCDwOpFueBgC0Hzy85uJg-o5oUjvBpNWHj0SaajYk	cmtvlfvrl0016c68ctku1w5rk	CUSTOMER	2026-09-17 13:59:22.272	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	172.69.63.243	2026-09-10 13:59:22.273
cmtvlifg10019c68clzp80f4s	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MDQ4ODgxLCJleHAiOjE3ODk2NTM2ODF9.XM9Sk2lghgDUXb8Cit5I1fuFLOEYUzPXYIN3BTsHW2Y	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-17 14:01:21.073	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	104.23.168.42	2026-09-10 14:01:21.074
cmtvm1q1x001cc68cqjqxe8jb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MDQ5NzgxLCJleHAiOjE3ODk2NTQ1ODF9.B74dyPdhZ8EIx73Hp1wDp5lnleQwXl5-ckCtAT1DmFY	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-17 14:16:21.285	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	\N	\N	\N	172.68.55.202	2026-09-10 14:16:21.285
cmtvmgz3p001nc68c3gant3kw	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bGZ2cmwwMDE2YzY4Y3RrdTF3NXJrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUwNDkyLCJleHAiOjE3ODk2NTUyOTJ9.FKNi9jMBZ1EiWoubSe72zQZr6ThDlZ18kq7hDqZaeiU	cmtvlfvrl0016c68ctku1w5rk	CUSTOMER	2026-09-17 14:28:12.853	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-10 14:28:12.854
cmtvmkwlt001sc68cow1opdgg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bWtzOXQwMDFwYzY4Y3UzOHg5bGM0Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MDY3NiwiZXhwIjoxNzg5NjU1NDc2fQ.KNRUjZKIQPqHbJi2D6PguH2mwOE09dGVlwAIKsgpeEY	cmtvmks9t001pc68cu38x9lc4	VENDOR	2026-09-17 14:31:16.241	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-10 14:31:16.242
cmtvml0wx001tc68c9z9nrk9m	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bGZ2cmwwMDE2YzY4Y3RrdTF3NXJrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUwNjgxLCJleHAiOjE3ODk2NTU0ODF9.B24slWho63llHo0B4WujbhxXtOX1ihkql60MmuLGZLw	cmtvlfvrl0016c68ctku1w5rk	CUSTOMER	2026-09-17 14:31:21.825	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-10 14:31:21.826
cmtvmmiz20020c68cu6vhyfmx	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MDUwNzUxLCJleHAiOjE3ODk2NTU1NTF9.YXvb67UzxUapvsVco5NlIekaQUtnnK9qSksQeRuidUU	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-17 14:32:31.886	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	\N	\N	\N	104.22.14.112	2026-09-10 14:32:31.887
cmtvmq4bc0021c68c8bu5weyk	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MDUwOTE5LCJleHAiOjE3ODk2NTU3MTl9.Ey9ze7jqfDn3SKm_c66jsc9uCd_l-8yZGKT18PukeIc	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-17 14:35:19.512	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	172.68.205.10	2026-09-10 14:35:19.513
cmtvmucth0022c68cmfynxrs9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bWtzOXQwMDFwYzY4Y3UzOHg5bGM0Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MTExNywiZXhwIjoxNzg5NjU1OTE3fQ.rAdkX9aCbWconmUXkKIXeGGozUlEwUcTCcBTIoNEgcM	cmtvmks9t001pc68cu38x9lc4	VENDOR	2026-09-17 14:38:37.157	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	104.22.14.112	2026-09-10 14:38:37.158
cmtvmului0023c68cl3f2pa22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bGZ2cmwwMDE2YzY4Y3RrdTF3NXJrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUxMTI4LCJleHAiOjE3ODk2NTU5Mjh9.YwLP1-y4AVWaEIAGQltEckwioVQLsJ_8jRCmwkoAsQs	cmtvlfvrl0016c68ctku1w5rk	CUSTOMER	2026-09-17 14:38:48.858	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	104.22.14.112	2026-09-10 14:38:48.858
cmtvmutth0024c68c20zv2n4s	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MTEzOSwiZXhwIjoxNzg5NjU1OTM5fQ.J433TYoPfKOzGPTnn8fc-IZNfg1rZ2rU_tHIdHm1eE8	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 14:38:59.188	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.76.54	2026-09-10 14:38:59.189
cmtvmuykr0025c68ca56ox7xg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bWtzOXQwMDFwYzY4Y3UzOHg5bGM0Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MTE0NSwiZXhwIjoxNzg5NjU1OTQ1fQ.tXlNlyibwmnMuG1GYDrk3P1Ipid8LAM_INrh90sfEQM	cmtvmks9t001pc68cu38x9lc4	VENDOR	2026-09-17 14:39:05.355	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	104.22.14.112	2026-09-10 14:39:05.356
cmtvmzjlx0029c68c1xu3mxk1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bGZ2cmwwMDE2YzY4Y3RrdTF3NXJrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUxMzU5LCJleHAiOjE3ODk2NTYxNTl9.HGBMzp8myIY14p4mrGVgu3o-ZV13Bq6h98iuwK1rI-E	cmtvlfvrl0016c68ctku1w5rk	CUSTOMER	2026-09-17 14:42:39.236	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	104.22.14.112	2026-09-10 14:42:39.237
cmtvmznmv002ac68c1dydwexg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bWtzOXQwMDFwYzY4Y3UzOHg5bGM0Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MTM2NCwiZXhwIjoxNzg5NjU2MTY0fQ.DN_uIGf-wnWcIZIBp7aRsAct-ok1iOFxFY3OuPl74RY	cmtvmks9t001pc68cu38x9lc4	VENDOR	2026-09-17 14:42:44.455	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	104.22.14.112	2026-09-10 14:42:44.455
cmtvn0b5u002bc68c0d1lsdj2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bGZ2cmwwMDE2YzY4Y3RrdTF3NXJrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUxMzk0LCJleHAiOjE3ODk2NTYxOTR9.5APOwb_ERzVkNdL4ew_uy-uaLa1QY2px8Ne7R0Lnf5k	cmtvlfvrl0016c68ctku1w5rk	CUSTOMER	2026-09-17 14:43:14.946	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	162.159.99.64	2026-09-10 14:43:14.946
cmtvn0e44002cc68cjjdx7e2g	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bWtzOXQwMDFwYzY4Y3UzOHg5bGM0Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MTM5OCwiZXhwIjoxNzg5NjU2MTk4fQ.SByVcTILgwsR6RqggXpfWB6XE27pSW6V--Rw0uEAaW4	cmtvmks9t001pc68cu38x9lc4	VENDOR	2026-09-17 14:43:18.772	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	162.159.99.64	2026-09-10 14:43:18.773
cmtvn14pn002dc68ceqdbaavr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bGZ2cmwwMDE2YzY4Y3RrdTF3NXJrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUxNDMzLCJleHAiOjE3ODk2NTYyMzN9.LillTLRWZ8BilSvY2ZtpFoWHkVY4eFlHUuddB73BiqU	cmtvlfvrl0016c68ctku1w5rk	CUSTOMER	2026-09-17 14:43:53.243	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	162.159.99.64	2026-09-10 14:43:53.244
cmtvn2fj8002ec68ct0caefxs	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bWtzOXQwMDFwYzY4Y3UzOHg5bGM0Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MTQ5MywiZXhwIjoxNzg5NjU2MjkzfQ.rsGEwffI7OFB0_7HnrhyIkUhaoLA-VilbDvdEt2byEY	cmtvmks9t001pc68cu38x9lc4	VENDOR	2026-09-17 14:44:53.923	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	172.68.55.202	2026-09-10 14:44:53.924
cmtvn2iy3002fc68cjy2pj8vh	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bGZ2cmwwMDE2YzY4Y3RrdTF3NXJrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUxNDk4LCJleHAiOjE3ODk2NTYyOTh9.1tntJYy3BQvkVIAj34ec2aZwY_qcNgLsL54G1v0Y-to	cmtvlfvrl0016c68ctku1w5rk	CUSTOMER	2026-09-17 14:44:58.347	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	172.68.55.202	2026-09-10 14:44:58.348
cmtvn2qlh002gc68cy012367o	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bWtzOXQwMDFwYzY4Y3UzOHg5bGM0Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MTUwOCwiZXhwIjoxNzg5NjU2MzA4fQ.Yv-OXLin1qRzqo1HhNyAwYbUdAQ8Z-8Kf2pOCK_TjJY	cmtvmks9t001pc68cu38x9lc4	VENDOR	2026-09-17 14:45:08.261	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	172.68.55.202	2026-09-10 14:45:08.261
cmtvn46cu002lc68crwc9g4jg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bGZ2cmwwMDE2YzY4Y3RrdTF3NXJrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUxNTc1LCJleHAiOjE3ODk2NTYzNzV9.DiSJRJyAzNblBk0ecMRkQSSsdB_ZSRrqL9Kl1db1F8Y	cmtvlfvrl0016c68ctku1w5rk	CUSTOMER	2026-09-17 14:46:15.342	okhttp/4.12.0	9d4607c04625c886	CPH2721	16	104.22.14.112	2026-09-10 14:46:15.342
cmtvnas94002mc68c4mukjk4u	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtb2NseXYwMDIyYzZka3lpNDE1dDhyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUxODgzLCJleHAiOjE3ODk2NTY2ODN9.rz6LmXp8pITToME9R_Mo6l4UwuuYw7V-slEXVFrsGTE	cmtmoclyv0022c6dkyi415t8r	CUSTOMER	2026-09-17 14:51:23.656	okhttp/4.12.0	5c80fc85daa1040b	V2303	15	172.68.55.202	2026-09-10 14:51:23.656
cmtvntgk5003mc68cnu73jexv	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUyNzU0LCJleHAiOjE3ODk2NTc1NTR9.mKWCyk7uI3W17XhoF3NF5nDd9eaOBz_aJq_8VK1qqqk	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:05:54.964	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.69.22	2026-09-10 15:05:54.965
cmtvntifg003nc68cspqcq7wx	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1Mjc1NywiZXhwIjoxNzg5NjU3NTU3fQ.k3VjlGLvD1Qf0660JjNSOykeyQ6xTMFN6zi1zFq5fL8	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:05:57.387	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:05:57.388
cmtvntkjs003oc68c6hdv4t9f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUyNzYwLCJleHAiOjE3ODk2NTc1NjB9.DNGqUBTU7cBx6jhR7q3njmpvC7AhGLZqqddVA3G8tig	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:06:00.135	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:06:00.136
cmtvntv0j003pc68chmru62zr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1Mjc3MywiZXhwIjoxNzg5NjU3NTczfQ.rx49BuBpCLAOimRfijI7GSl0uT3qw7vm0tnFjgKdEQc	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:06:13.699	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:06:13.699
cmtvo14gn003qc68cp7zgtgsj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUzMTEyLCJleHAiOjE3ODk2NTc5MTJ9.oLap-mdNneqaMf6OcUnsH_dr2ZvkP4wZh7znvq1QB_U	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:11:52.535	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:11:52.536
cmtvo1q3c003sc68chvdwhna5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MzE0MCwiZXhwIjoxNzg5NjU3OTQwfQ.dedbdAH_MtWxS8JOJb9Ay1xr_2sjqL1DcNhiMMaF4_4	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:12:20.568	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:12:20.569
cmtvo4yd9003tc68chkuv5zev	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUzMjkxLCJleHAiOjE3ODk2NTgwOTF9.00_n65diM5LH70G2Tjtw73KQLLN_HcM6Qeg8pa7Z2KY	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:14:51.26	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:14:51.261
cmtvo5t4y003uc68cp9l776pg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MzMzMSwiZXhwIjoxNzg5NjU4MTMxfQ.3Ucup7gu4AAvKFvDu9uGVbaXTnWLFKkmK6iB-oT9-DY	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:15:31.137	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:15:31.138
cmtvo60fz003vc68c59p3gbdd	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUzMzQwLCJleHAiOjE3ODk2NTgxNDB9.EpAw1DTz73pfQGC3TMQ3KXuoa7xsqSTDmtCF7pen9qQ	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:15:40.607	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:15:40.608
cmtvo65yx003wc68cc1fr9f5x	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MzM0NywiZXhwIjoxNzg5NjU4MTQ3fQ.6Q9NvHOcppfQsfPHDJYR6RtQXEQlLHxS2Kq8m8KhM0U	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:15:47.769	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:15:47.769
cmtvo6920003xc68cmzyy0nyd	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUzMzUxLCJleHAiOjE3ODk2NTgxNTF9.U5VmbuuUBm70qiVzjLWncfxggdJ_dGENUrcUsWORDQU	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:15:51.767	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:15:51.768
cmtvo9v0m003yc68cjfiyscc1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MzUyMCwiZXhwIjoxNzg5NjU4MzIwfQ.eLIbr-bSGzgxclYRvQKfmaTctR_J6rDhGWy5a2a9LEw	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:18:40.198	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:18:40.199
cmtvo9zhi003zc68chyge6ogp	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUzNTI1LCJleHAiOjE3ODk2NTgzMjV9.eM6wgzU9LwTLGjr8j2eQf2KoW_lzGM8hK3rtCzMGxRw	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:18:45.989	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:18:45.99
cmtvoal200040c68cwubnlprg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MzU1MywiZXhwIjoxNzg5NjU4MzUzfQ.kOXIk5aXZC32kj3WuCOGUj6BINUI0ATEG-jA48abzUA	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:19:13.943	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:19:13.944
cmtvobh190041c68cyt3aioc8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUzNTk1LCJleHAiOjE3ODk2NTgzOTV9.Hl_MKEIKtYoIJBxsavHN5ZTfw4KgMv0iV4FMPrOm8CE	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:19:55.389	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:19:55.389
cmtvocrr00042c68cd8cb5z7g	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MzY1NSwiZXhwIjoxNzg5NjU4NDU1fQ.JG3Lu1zYGuZZnRBGihVF2hLmiHeWtHUv-Qgdd2mUIhM	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:20:55.932	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:20:55.933
cmtvoctx80043c68c4put1thz	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUzNjU4LCJleHAiOjE3ODk2NTg0NTh9.Mk6skIXyzGhNgJ70xw-gxoF3FL-1DXY8CbLCb-G4x7k	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:20:58.748	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:20:58.748
cmtvod5ns0044c68cly4gqg18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MzY3MywiZXhwIjoxNzg5NjU4NDczfQ.hN-v2Pyc-JN_g_UZcGv03czB6_fqLM5Msswi92PlMcg	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:21:13.959	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:21:13.96
cmtvodqq80045c68cse97g8tu	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUzNzAxLCJleHAiOjE3ODk2NTg1MDF9.dLgCTr2lQi6onlctDhwujT4vmm07SRorGxL2lwVdOOA	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:21:41.264	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:21:41.265
cmtvofon40046c68cr77udbku	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1Mzc5MSwiZXhwIjoxNzg5NjU4NTkxfQ.bQWxPkgznZRapKe3auApn4j0JVklEVHC491OkIYGbyY	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:23:11.872	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:23:11.873
cmtvog6lp0047c68cgfgi5isa	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUzODE1LCJleHAiOjE3ODk2NTg2MTV9.GZYEyT33O0JECyJMtJ-HRM8Nw_omAzj38Mw14ckWaDs	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:23:35.148	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:23:35.149
cmtvogbj90048c68c120o5qhv	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MzgyMSwiZXhwIjoxNzg5NjU4NjIxfQ.ARZAhxzNhDAm5cjUGYw76zD3jPCWblod2wunuV-sAPw	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:23:41.541	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:23:41.542
cmtvogdx20049c68cjcp9l3h0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUzODI0LCJleHAiOjE3ODk2NTg2MjR9.DVxGtNYwCd_OzjQOXtfV2zu5Ejys7wAHVrPeeJkexX8	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:23:44.629	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:23:44.63
cmtvoggoz004ac68comrzi997	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1MzgyOCwiZXhwIjoxNzg5NjU4NjI4fQ.njL_PWYk4nD8ShZr8AtjYYaiw-gO1DRC_X9pfriQOoU	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:23:48.227	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:23:48.227
cmtvogin3004bc68cd4q8v9ke	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDUzODMwLCJleHAiOjE3ODk2NTg2MzB9.tqtfgNE_im258fcM5Z55rflnjvTvlQI5LyMSu664NNM	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:23:50.75	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:23:50.751
cmtvom270004cc68cezfqpw5q	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDA4OSwiZXhwIjoxNzg5NjU4ODg5fQ.8fTBSEcMIgtBtZDuDavdpCZ4jWpQmyIKEe3qrHF1UyI	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:28:09.371	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:28:09.372
cmtvom4gf004dc68cqu2erfob	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0MDkyLCJleHAiOjE3ODk2NTg4OTJ9.y1813KhJGgsvOQMGqdY1itVgFRgWrvquCQ9Ipec2ax8	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:28:12.302	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:28:12.303
cmtvomg5q004ec68cuxxn60oc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDEwNywiZXhwIjoxNzg5NjU4OTA3fQ._Pta4v3Q8MWZW6IYIjJVJMc2ho-uiQqVUyns04iXibg	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:28:27.47	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:28:27.471
cmtvomil5004fc68ckeza2iw3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0MTEwLCJleHAiOjE3ODk2NTg5MTB9.q43mPaNuZMCHDWZG0HCHKMGtPsoF-8b4mSeL8hym6rM	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:28:30.617	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:28:30.617
cmtvomvce004gc68c4w7xnd4v	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDEyNywiZXhwIjoxNzg5NjU4OTI3fQ.375NnqAJO8_cCCHyQ-3tPRwdVjPV_mgAtis2pvYPh5c	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:28:47.15	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:28:47.151
cmtvoncvd004hc68cyg48vjsx	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0MTQ5LCJleHAiOjE3ODk2NTg5NDl9.ylr3ub5IWYnCVALGDRpXLEZX39irVQW2NHqW_aVMc90	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:29:09.865	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:29:09.865
cmtvopc67004ic68cpqxyaago	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDI0MiwiZXhwIjoxNzg5NjU5MDQyfQ.b8nY9VJ4yQjij3wGCSmmL8EDs2h4ej4srUTTCwPEYP8	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:30:42.271	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:30:42.272
cmtvopei8004jc68c2i3m2wz1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0MjQ1LCJleHAiOjE3ODk2NTkwNDV9.MfImheZt20f9TJTHa8v486uWq5yK9gYN6vc3_tF6d-0	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:30:45.296	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:30:45.297
cmtvopn33004kc68c4ge1a9w9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDI1NiwiZXhwIjoxNzg5NjU5MDU2fQ.5hKMaEdr6uTpQGTXTtzRmBNHIPWXoGL4DJ67wrfLmls	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:30:56.415	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:30:56.415
cmtvoppc8004lc68chg1z0imj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0MjU5LCJleHAiOjE3ODk2NTkwNTl9.LRQsqMULIz4D8fx8FRrUgXaXhbNmWlRxFjJHJm929iA	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:30:59.336	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:30:59.337
cmtvoq2d7004mc68c7vg84xtc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDI3NiwiZXhwIjoxNzg5NjU5MDc2fQ.y5OHKGMGniVOPEy3iGS2f7IjAaCw09rvOg9Y3idkaBI	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:31:16.219	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:31:16.22
cmtvoq589004nc68c7k2sqpzc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0Mjc5LCJleHAiOjE3ODk2NTkwNzl9.CvA2qq8Y_Ht4rdS9kZA_lR48WOG58jv0V3KjN-CMdAk	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:31:19.922	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:31:19.93
cmtvoqdue004oc68c60folr2b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDI5MSwiZXhwIjoxNzg5NjU5MDkxfQ.4J8BxjcQ1Mf44c3YAbBivFSEzqajtUD6TX7tkvNjD8M	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:31:31.094	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:31:31.095
cmtvoqi4m004pc68cb0bmndef	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0Mjk2LCJleHAiOjE3ODk2NTkwOTZ9.Qjio8n_Q0F2TafuOYTlLsn-GxMWqQuWWBCT0oqBtFdg	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:31:36.646	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:31:36.647
cmtvoqkt8004qc68cbz3emo0q	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDMwMCwiZXhwIjoxNzg5NjU5MTAwfQ.SIJY5alpmbYRhfCjoZqyDH1VT-clSF_pKs3G2Om7hKk	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:31:40.124	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:31:40.125
cmtvoqodd004rc68csxsl2i8n	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0MzA0LCJleHAiOjE3ODk2NTkxMDR9.1z09_nuVCJ2KWh5TpsUn7ZY8JmbWHF-F8-Zw8zutZzw	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:31:44.737	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:31:44.737
cmtvoqup4004sc68c9tz0ucpj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDMxMiwiZXhwIjoxNzg5NjU5MTEyfQ.0L0paKOoNY6YNBezOJsVspEZ0zLu1K6IAxbpyCCs3AM	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:31:52.935	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:31:52.937
cmtvoqx3o004tc68cp3ma6ywq	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0MzE2LCJleHAiOjE3ODk2NTkxMTZ9.x4lJ8p9wptbu8SATmBTUG7-YCCp0V8NXyIN8Xb9s-AQ	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:31:56.052	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:31:56.053
cmtvor1d6004uc68ck8nhkrn9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDMyMSwiZXhwIjoxNzg5NjU5MTIxfQ.CVhZzKLVVgJ0WZHEAatLWyEozXSQraxLrTY1lyy26Ss	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:32:01.578	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:32:01.579
cmtvor7i3004vc68c558lhw9g	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0MzI5LCJleHAiOjE3ODk2NTkxMjl9.7cs_QHNkXRAm4y3PTHR8qTxG_0Matc9dCJtc5JlKXCs	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:32:09.529	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.189	2026-09-10 15:32:09.53
cmtvou2u2004wc68czjlkfbtf	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDQ2MywiZXhwIjoxNzg5NjU5MjYzfQ.ElxHDQEUva-Xp_27fAzrqulKjPM_dlkVtxJfXhnrOaQ	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:34:23.45	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:34:23.45
cmtvou5ca004xc68cfrv437nr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0NDY2LCJleHAiOjE3ODk2NTkyNjZ9.kKDznc0YClcxEGWIYEzwB7yOuLfZYm2v2tvXNqCi-qo	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:34:26.697	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:34:26.698
cmtvourhz004yc68clpcwrzzi	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDQ5NSwiZXhwIjoxNzg5NjU5Mjk1fQ.csIgB-oUButBo1hXBzzVim0_Fm8_JUbH--_ekx_jcvs	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:34:55.415	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:34:55.415
cmtvoutzn004zc68ciajezdp4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0NDk4LCJleHAiOjE3ODk2NTkyOTh9.X81JSBr_iEFWnvajdK242iGrz4V0tMPtlB5ktgSHhhc	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:34:58.642	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:34:58.643
cmtvouwq40050c68cgy8xjhm0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDUwMiwiZXhwIjoxNzg5NjU5MzAyfQ.qWKJFNNo3ZPuClmS-HayB52ijXBbzjiUW847gthmKPQ	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:35:02.188	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:35:02.189
cmtvovhfc0053c68c97xtdxfl	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0NTI5LCJleHAiOjE3ODk2NTkzMjl9.kNfUmFpYTdKS0mGJ1mQ5TT8nBG1Tze1xlfvN4sMS8iE	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:35:29.012	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:35:29.017
cmtvowdbf0054c68c40b06shb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDU3MCwiZXhwIjoxNzg5NjU5MzcwfQ.wnsv7n7dD_pI6aXQs9J4mepZg2WqmsEd87_D0Od2LQw	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:36:10.347	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:36:10.348
cmtvowgn40055c68cyk6i7d6x	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0NTc0LCJleHAiOjE3ODk2NTkzNzR9.ftlhvR8yL4jDjZnAk6bJKe0DDsVJhMjXHUG_bkb3CnQ	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:36:14.656	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:36:14.657
cmtvowjbz0056c68ch4y2pwmc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDU3OCwiZXhwIjoxNzg5NjU5Mzc4fQ.DQ9b5aGNO685DGNBbpTPyY8dpm9jQT3ZGG2jyWRjJaM	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:36:18.143	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:36:18.144
cmtvowwdz0057c68cgowjk8s4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0NTk1LCJleHAiOjE3ODk2NTkzOTV9.OzgXp5QnT1gCCsbmyiXKIh08O85JgbEJ514-9F9HYec	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:36:35.063	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:36:35.063
cmtvoxh990058c68cf7zo3rs5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDYyMiwiZXhwIjoxNzg5NjU5NDIyfQ.p3_POMxEyn-iV54JZ8A7P8MqEg9yAg44AksEVHYrbXc	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:37:02.109	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:37:02.11
cmtvouz4d0051c68chwk1e6bl	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0NTA1LCJleHAiOjE3ODk2NTkzMDV9.zDeYdYkeHut-Pp5gbl9SatrizzSRUWtdO2ITJhoAy9U	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:35:05.293	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:35:05.294
cmtvovf000052c68cwihlc0ee	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDUyNSwiZXhwIjoxNzg5NjU5MzI1fQ.eeNQVPZOEZB8IOpf9aJsgCaeiUYj5lvPgnTj9iyg6MM	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:35:25.868	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:35:25.872
cmtvoxkw40059c68c8rglgyqw	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0NjI2LCJleHAiOjE3ODk2NTk0MjZ9.kbSZ2I2wG5FZfrKckMKZXffoTxkVdyNcdcwDKEF3r2o	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:37:06.82	okhttp/4.12.0	211a141fbd5b2945	V2511	16	141.101.68.188	2026-09-10 15:37:06.82
cmtvp0zxd005ac68cy68zbz3o	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDc4NiwiZXhwIjoxNzg5NjU5NTg2fQ.OOvHzKwKNiEympub2EzrxGaIMtLh-NnjQlkesxY9-cs	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:39:46.273	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.168.32	2026-09-10 15:39:46.273
cmtvp12e9005bc68ct8o92zsr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0Nzg5LCJleHAiOjE3ODk2NTk1ODl9.Dps8hxstY4nKG65vIAu3CuSK9tgdpITmebHLjjN7BSg	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:39:49.473	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.168.32	2026-09-10 15:39:49.473
cmtvp2wgb005cc68cwcrm892h	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDg3NSwiZXhwIjoxNzg5NjU5Njc1fQ.ZcQiQcr7nCKz_BJ2azr_wG2Rv6pgLGhUNLS3IWEJn-0	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:41:15.083	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.168.32	2026-09-10 15:41:15.083
cmtvp40a9005dc68cfulyuy5a	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0OTI2LCJleHAiOjE3ODk2NTk3MjZ9.UQoMlqw9JHXvOE0MwTlLdg7fnlIwiwc9nDuTQukXJ9M	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:42:06.705	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.168.32	2026-09-10 15:42:06.706
cmtvp461o005ec68cialn2rx6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NDkzNCwiZXhwIjoxNzg5NjU5NzM0fQ.9oKqqoDHRAlMfNx5AZi2n5uyPNPLYd6xCaKQXOtMc0M	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:42:14.171	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.168.32	2026-09-10 15:42:14.172
cmtvp4ers005fc68cbeik5er0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU0OTQ1LCJleHAiOjE3ODk2NTk3NDV9.j-4nr4DZw5m8uquHBbkWsiIOFsB4w15LlU4l30GV3Ws	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:42:25.48	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.168.32	2026-09-10 15:42:25.481
cmtvpcnpb005gc68cac44toft	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NTMzMCwiZXhwIjoxNzg5NjYwMTMwfQ.GeObGpZ_Nw7slneoki167Sn5LhhzduN2Q6otZCVv8MM	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:48:50.303	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.168.32	2026-09-10 15:48:50.303
cmtvpcsga005hc68ce4w2rysj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU1MzM2LCJleHAiOjE3ODk2NjAxMzZ9.psfp01MtlkRt4YZChwO-vGbeprZsk7P5QhjIAPrwVdY	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:48:56.457	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.168.32	2026-09-10 15:48:56.458
cmtvpf3bn005ic68cv7yilq1i	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1NTQ0MywiZXhwIjoxNzg5NjYwMjQzfQ.jGeQB3RWzsAtgTQleJdX-IJ-heo0dQQ3OH1oOMHA6NI	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 15:50:43.859	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.168.32	2026-09-10 15:50:43.86
cmtvpf5sh005jc68cvaupzk5v	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU1NDQ3LCJleHAiOjE3ODk2NjAyNDd9.UPFoiD7sO5sHHL_D8VZctCkxkgfacXRx7YQwZqn_FSI	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 15:50:47.056	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.168.32	2026-09-10 15:50:47.058
cmtvqwnje005mc68cumq9syto	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1Nzk0MiwiZXhwIjoxNzg5NjYyNzQyfQ.ZNiyNwjZvATt6iyKNoT01uh7lED8OLBZq9WJaS3MbSc	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 16:32:22.825	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.170.32	2026-09-10 16:32:22.826
cmtvqx8cs005nc68cg2vifs5j	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU3OTY5LCJleHAiOjE3ODk2NjI3Njl9.YYfdfn-UvnckafGAPtQB6xfLQE5xKY3cb9OPnEhPVLk	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 16:32:49.803	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.170.32	2026-09-10 16:32:49.804
cmtvr71ib005xc68chr323w2j	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MDU4NDI3LCJleHAiOjE3ODk2NjMyMjd9.4W4p8WaK3PMv-RMN6na0GYYw5tkWsPybFDjhPHS06B8	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-17 16:40:27.49	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	\N	\N	\N	172.68.55.202	2026-09-10 16:40:27.491
cmtvrvqlu0000c6w8avmrkioc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1OTU3OSwiZXhwIjoxNzg5NjY0Mzc5fQ.GvmZvWSSCxi50CdCT7BABYIOjSITGhQ917_C25TqKzs	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 16:59:39.761	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.170.33	2026-09-10 16:59:39.762
cmtvrvua70001c6w8mmb8zrcg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU5NTg0LCJleHAiOjE3ODk2NjQzODR9.8ZC1v2w9esD-sQw4KU19Ompg58DA-1-cXNqNkPaqWKA	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 16:59:44.527	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.170.33	2026-09-10 16:59:44.528
cmtvrvw8s0002c6w8158bt4dk	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1OTU4NywiZXhwIjoxNzg5NjY0Mzg3fQ.WUewLwCwV6QQgG7Mw2njqSSioea1lvlXEUkY8FocXy8	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 16:59:47.068	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.170.33	2026-09-10 16:59:47.068
cmtvrvzo00003c6w81d7wir0o	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU5NTkxLCJleHAiOjE3ODk2NjQzOTF9.FbvIEwSTt9H8P4Rimp3cIxdMub2XycosnPofaN9sLwA	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 16:59:51.504	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.170.33	2026-09-10 16:59:51.505
cmtvrw4wv0004c6w8zr8x63ur	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1OTU5OCwiZXhwIjoxNzg5NjY0Mzk4fQ.bY5OvjHrcVf0ilwsh0aVITg72jlt2k8BTARHEq15JYo	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 16:59:58.303	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.170.33	2026-09-10 16:59:58.304
cmtvrw7lx0005c6w826vvkhka	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU5NjAxLCJleHAiOjE3ODk2NjQ0MDF9.-AhhmfrGKuSvssrSo__Fp0dqjckWih20kG6LVMbdI00	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 17:00:01.79	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.170.33	2026-09-10 17:00:01.797
cmtvs1bde000oc6w8hf205jfk	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1OTgzOSwiZXhwIjoxNzg5NjY0NjM5fQ.L6hX1lWvsbzf6bHeXAll6St4LpPAWxwLOzTaO5aNzXQ	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 17:03:59.953	okhttp/4.12.0	211a141fbd5b2945	V2511	16	162.159.113.35	2026-09-10 17:03:59.954
cmtvs1ewp000pc6w88diyib0y	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU5ODQ0LCJleHAiOjE3ODk2NjQ2NDR9.rmgNFmnG0L9YOB6MX2ZWBK1sKn7xRNChS4zJ6dMrJu0	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 17:04:04.537	okhttp/4.12.0	211a141fbd5b2945	V2511	16	162.159.113.35	2026-09-10 17:04:04.538
cmtvs1q24000qc6w8bf7zasyo	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTA1OTg1OCwiZXhwIjoxNzg5NjY0NjU4fQ.ijAZwgPBj9Gb30wWATJ9QTVwwW0n52TdaDZiMGwAqbY	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-17 17:04:18.988	okhttp/4.12.0	211a141fbd5b2945	V2511	16	162.159.113.35	2026-09-10 17:04:18.989
cmtvs2b37000rc6w81yl1bzlt	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MDU5ODg2LCJleHAiOjE3ODk2NjQ2ODZ9.wKpruH7oTXwT5TgrZqlStqSKKBDTLRc5q8Nej7slZeM	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-17 17:04:46.243	okhttp/4.12.0	211a141fbd5b2945	V2511	16	162.159.113.35	2026-09-10 17:04:46.244
cmtwgt9qj000vc6w82h9fgdqa	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bWtzOXQwMDFwYzY4Y3UzOHg5bGM0Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTEwMTQ1NCwiZXhwIjoxNzg5NzA2MjU0fQ.RIzTdzmCUqNWv1xVcZhy_qvxvVBlkRDBxfDLlHf2gOI	cmtvmks9t001pc68cu38x9lc4	VENDOR	2026-09-18 04:37:34.987	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.23.172.61	2026-09-11 04:37:34.988
cmtwgtbzy000wc6w8v0jwg0ki	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bGZ2cmwwMDE2YzY4Y3RrdTF3NXJrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTAxNDU3LCJleHAiOjE3ODk3MDYyNTd9.EKDJrh9UV-uyGWA-F6iAmJNDzxup3jqMf4OzqwgzwNQ	cmtvlfvrl0016c68ctku1w5rk	CUSTOMER	2026-09-18 04:37:37.918	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.23.172.61	2026-09-11 04:37:37.919
cmtwgtrkh000xc6w8fnoov3j1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bWtzOXQwMDFwYzY4Y3UzOHg5bGM0Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTEwMTQ3OCwiZXhwIjoxNzg5NzA2Mjc4fQ.DgvZpE1r1DriSy0nEMoQ0zGOnJvJtwT1KZUs-8waRoM	cmtvmks9t001pc68cu38x9lc4	VENDOR	2026-09-18 04:37:58.097	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.23.172.61	2026-09-11 04:37:58.098
cmtwgu0xx000yc6w8rfnu0bmg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bGZ2cmwwMDE2YzY4Y3RrdTF3NXJrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTAxNDkwLCJleHAiOjE3ODk3MDYyOTB9.J4uF8uJzXrCBhHNaL42hzC-Ll3-N6i7iqvaprIFxDmk	cmtvlfvrl0016c68ctku1w5rk	CUSTOMER	2026-09-18 04:38:10.245	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.23.172.61	2026-09-11 04:38:10.246
cmtwjsc560016c6w8mzo2hpel	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTA2NDUwLCJleHAiOjE3ODk3MTEyNTB9.-cZEFXDjjLlsBBtSLHhDwGqtZJgZaHmFzTVMLrDhbn4	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-18 06:00:50.297	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-11 06:00:50.298
cmtwjsfbg0017c6w8iu80aklv	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTEwNjQ1NCwiZXhwIjoxNzg5NzExMjU0fQ.hvOs1B60LkBujeyPyMySHZzi3wFEjtH1OKi1LwOzy-k	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-18 06:00:54.412	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-11 06:00:54.413
cmtwjt96v0018c6w8i8rru0a9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTA2NDkzLCJleHAiOjE3ODk3MTEyOTN9.BRHYbZNPrWezNR1RdK1_DcTLvjx5ZewaaD_D2OXcMNE	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-18 06:01:33.126	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-11 06:01:33.127
cmtwkilzr0019c6w8pohloeba	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MTA3Njc2LCJleHAiOjE3ODk3MTI0NzZ9.EIwLEnXPqc-9C8EEjwx8_LD6Hqz_nLKlylwTNn1ZW2k	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-18 06:21:16.119	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	104.23.172.61	2026-09-11 06:21:16.119
cmtwko4c0001bc6w8xcrhat10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTA3OTMzLCJleHAiOjE3ODk3MTI3MzN9.BOvleE_EloCYNQweD0L7UWzDgpEywGCumc26_NRPuow	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-18 06:25:33.168	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	172.68.55.202	2026-09-11 06:25:33.169
cmtwreo8k0002c6kghapqpo78	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTExOTI0OSwiZXhwIjoxNzg5NzI0MDQ5fQ.fqSNIsNBu6x7-5g5jz96tbB7eQcF-b6Lro4Q-KTJa-s	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-18 09:34:09.713	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.170.33	2026-09-11 09:34:09.716
cmtwreqts0003c6kga0caxjp1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTE5MjUzLCJleHAiOjE3ODk3MjQwNTN9.AM1Q-tatrN_Tg77oNZcCLSKM14glrnMoa4_hbU8WflE	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-18 09:34:13.072	okhttp/4.12.0	211a141fbd5b2945	V2511	16	104.23.170.33	2026-09-11 09:34:13.073
cmtwsssbp0000c68mjgo7c5t4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MTIxNTg3LCJleHAiOjE3ODk3MjYzODd9._FHvcmTn5iH302ADyYWdwIUWVHPHkomwW-uMHCzsBEg	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-18 10:13:07.811	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	\N	\N	\N	104.23.170.33	2026-09-11 10:13:07.813
cmtwwhtz70003c68m3vnngtv9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bWtzOXQwMDFwYzY4Y3UzOHg5bGM0Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTEyNzc5NSwiZXhwIjoxNzg5NzMyNTk1fQ.AjFnJpqHzUHNrZalNoPGTOTFCGIz6Ow8oZUreUl1nv0	cmtvmks9t001pc68cu38x9lc4	VENDOR	2026-09-18 11:56:35.2	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-11 11:56:35.203
cmtwwhzm80004c68m3j7shk8p	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bGZ2cmwwMDE2YzY4Y3RrdTF3NXJrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTI3ODAyLCJleHAiOjE3ODk3MzI2MDJ9.RBm6lYnKNWKXgkwM1A6jXCrbSD-STus0lgB46dYnsoc	cmtvlfvrl0016c68ctku1w5rk	CUSTOMER	2026-09-18 11:56:42.512	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-11 11:56:42.513
cmtwwjw8m0005c68my86yvs15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTEyNzg5MSwiZXhwIjoxNzg5NzMyNjkxfQ.64abblp7x9bwqyyhh8f2Os5dTimB4smhrKONIw_Na1g	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-18 11:58:11.446	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	172.68.55.202	2026-09-11 11:58:11.447
cmtwwkcao0006c68metps4fjy	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTI3OTEyLCJleHAiOjE3ODk3MzI3MTJ9.xCM7m3OmEUN6W85XfIizj3sDiOzWbHjNJMV6E_rz7Mk	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-18 11:58:32.256	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	172.68.55.202	2026-09-11 11:58:32.257
cmtwwm9ej0009c68mlu63kvpo	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MTI4MDAxLCJleHAiOjE3ODk3MzI4MDF9.jDFdO7TJSJnqFogvkvWohCOJYH3m_onI26h0bW0BNAE	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-18 12:00:01.818	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	104.23.170.32	2026-09-11 12:00:01.819
cmtwwv0py000jc68mfgeck8d7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR3d3YwcGUwMDBoYzY4bWJ6NnB5dTFnIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTI4NDEwLCJleHAiOjE3ODk3MzMyMTB9.TLcjL1sa7hn4NS3j2DJnkUbVn299SjRFwJOkf5eT10M	cmtwwv0pe000hc68mbz6pyu1g	CUSTOMER	2026-09-18 12:06:50.47	okhttp/4.12.0	7a12df252ac86694	V2312	15	172.70.189.98	2026-09-11 12:06:50.471
cmtwzsg6p000mc68m1y2qhmla	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR3enNnNWEwMDBrYzY4bWcwMWF1b240Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTMzMzI5LCJleHAiOjE3ODk3MzgxMjl9.d3gzlj8m5r487frWc-0RiYHlBFCv9z9O2jfVor2SrCw	cmtwzsg5a000kc68mg01auon4	CUSTOMER	2026-09-18 13:28:49.385	okhttp/4.12.0	58d2084c6a191be4	V2439	16	104.22.109.97	2026-09-11 13:28:49.393
cmtx00z0o000tc68m1bi2rjk3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR4MDBwMmQwMDBxYzY4bTk5YjByMGdhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTEzMzcyNywiZXhwIjoxNzg5NzM4NTI3fQ.MUJw3oIxxwgqr0czZEjxvXvf-2Ns326IwvIE1DfKL-M	cmtx00p2d000qc68m99b0r0ga	VENDOR	2026-09-18 13:35:27.047	okhttp/4.12.0	58d2084c6a191be4	V2439	16	104.22.109.97	2026-09-11 13:35:27.048
cmtx2lp6q0004c63vs930e1h7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR4MmxwNmkwMDAyYzYzdjh4dTJrdm44Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTM4MDUzLCJleHAiOjE3ODk3NDI4NTN9.CRYWoiTodcATBFC1eHluDSBEMTTeD2ZnUxhtc2jhmJw	cmtx2lp6i0002c63v8xu2kvn8	CUSTOMER	2026-09-18 14:47:33.314	okhttp/4.12.0	d9a91f3ed5369fee	Redmi 8A	10	104.22.14.112	2026-09-11 14:47:33.315
cmtx6qmz5000bc63vjh9qiusr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MTQ1MDAyLCJleHAiOjE3ODk3NDk4MDJ9.fV45RxIcqETS-W0N4HvMuV6LT5vSD6pTk6_kmM9o4RU	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-18 16:43:22.193	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	\N	\N	172.68.55.202	2026-09-11 16:43:22.194
cmtx6xru7000ec63vvpw0aqug	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR2bWtzOXQwMDFwYzY4Y3UzOHg5bGM0Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTE0NTMzNSwiZXhwIjoxNzg5NzUwMTM1fQ.n2Z4xKl7bt7raM9qAb_jNkwsXvy2VqnB_L8aXn9vYUs	cmtvmks9t001pc68cu38x9lc4	VENDOR	2026-09-18 16:48:55.087	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.23.172.60	2026-09-11 16:48:55.087
cmtxowo19000kc63vmdwkanvl	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTE3NTUxNiwiZXhwIjoxNzg5NzgwMzE2fQ.Q9xnPoCyeeZn2govBeczRjOngwuF-dXCdj5TIiJ28K4	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-19 01:11:56.583	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	172.68.55.202	2026-09-12 01:11:56.589
cmtxoywo9000lc63vu8lxq3y1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTc1NjIxLCJleHAiOjE3ODk3ODA0MjF9.IQP3NcYJKut-GJbOWDqf-VEGiq2Azcz4ht7jYFv6iFM	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-19 01:13:41.097	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	172.68.55.202	2026-09-12 01:13:41.098
cmtxrbyz8000nc63vsmlgutao	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTc5NTg5LCJleHAiOjE3ODk3ODQzODl9.NtJmpHaHc9g0blya2EubblyqSO4QvW-k8g0Cx38i6Xg	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-19 02:19:49.843	okhttp/4.12.0	37c0c246503697b8	V2511	16	141.101.76.159	2026-09-12 02:19:49.844
cmtxrc1lc000oc63v8gsdzy8e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTE3OTU5MywiZXhwIjoxNzg5Nzg0MzkzfQ.4kgsdSwUTwnotSVE-WBAMeG11GdUnrm6X682KvV9dDE	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-19 02:19:53.231	okhttp/4.12.0	37c0c246503697b8	V2511	16	141.101.76.55	2026-09-12 02:19:53.232
cmtxrcey9000pc63vb97ddh99	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MTc5NjEwLCJleHAiOjE3ODk3ODQ0MTB9.WQ5wlGb89vn95bdYf8hC5W_dE7Yx4Sj3KUPgXrsUhPo	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-19 02:20:10.545	okhttp/4.12.0	37c0c246503697b8	V2511	16	141.101.76.54	2026-09-12 02:20:10.546
cmty8viya000qc63v6xahravt	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTIwOTA1NSwiZXhwIjoxNzg5ODEzODU1fQ.1lIRjWm_oTD8F9IYC1yhNYWaE4ClRd8ogICqiT_2Xrs	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-09-19 10:30:55.664	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	104.22.14.112	2026-09-12 10:30:55.666
cmtyfvrnt000wc63v7cymg8a7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MjIwODI0LCJleHAiOjE3ODk4MjU2MjR9.aAReQR-wF_ktSfBHoGxHvmfL0y-o3E9BDp0oFSCw068	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-19 13:47:04.264	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	172.68.55.202	2026-09-12 13:47:04.265
cmtyg0mx0000xc63vm4xndkmi	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MjIxMDUxLCJleHAiOjE3ODk4MjU4NTF9.XUYpZiBv3Zwb2JDTze1kITIHbSTKLXDiNqfJsKJ69ZA	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-19 13:50:51.396	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	172.71.98.64	2026-09-12 13:50:51.397
cmtyga2w5000yc63vb302wlmy	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MjIxNDkyLCJleHAiOjE3ODk4MjYyOTJ9.wdFsSdvLO8b2PGDrJmu9CH6CdkSB8RHA3nZgMm42HQ0	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-09-19 13:58:12.004	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	104.22.14.112	2026-09-12 13:58:12.005
cmtyjh2y70023c63v0npg8pwk	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MjI2ODU3LCJleHAiOjE3ODk4MzE2NTd9.sx-8uLbGmFjp9As4hS5s8LZJ4Riw21TA-WsY8qSTbtA	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-19 15:27:37.518	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	162.159.113.35	2026-09-12 15:27:37.519
cmtyk8jau002ic63vbefdner5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR5azhqYTIwMDJnYzYzdnl2eDJzZHMzIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MjI4MTM4LCJleHAiOjE3ODk4MzI5Mzh9.LA22sRZcqcw1DCp9Xlz7J9tlEWQj1w9W82xA5cS-duk	cmtyk8ja2002gc63vyvx2sds3	CUSTOMER	2026-09-19 15:48:58.41	okhttp/4.12.0	c402128061e84df1	V2111	12	172.71.124.125	2026-09-12 15:48:58.421
cmtykv662002rc63v0bbb6qvb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MjI5MTk0LCJleHAiOjE3ODk4MzM5OTR9.FIj2TlBTfldDn2xebCvS2Z_GZtLFcuSEasUFndeP89k	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-19 16:06:34.49	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	162.159.113.80	2026-09-12 16:06:34.491
cmtyn83ai002sc63vgkfw4si8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MjMzMTU2LCJleHAiOjE3ODk4Mzc5NTZ9.xvR-hT52LpQpnUIMf6WQ8HBKq4ieMdYOie3T5vXJl1Y	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-19 17:12:36.522	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-12 17:12:36.522
cmtyn8cj3002tc63vyv20ewxx	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTIzMzE2OCwiZXhwIjoxNzg5ODM3OTY4fQ.FEeDrhxjZSw0c5TuNpHvdcXFVAjU60CNspQ4ZM2ZIvg	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-19 17:12:48.494	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-12 17:12:48.495
cmtyn8p3b002uc63vcepu6h3h	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MjMzMTg0LCJleHAiOjE3ODk4Mzc5ODR9.u-NZGAtAwe9jMTpwi1R9fuaNLQ3Eh9W2O5EX6u2Cwcc	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-19 17:13:04.774	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-12 17:13:04.775
cmu15fjhe0007c6441d2p4y83	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTM4NDY2OSwiZXhwIjoxNzg5OTg5NDY5fQ.H_8r69EiOZedc6qZfPIu2y3vsPEZ1t6z1pdscR7brnA	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-21 11:17:49.538	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.166.159	2026-09-14 11:17:49.539
cmu15hsia0008c644h13o8o6m	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5Mzg0Nzc0LCJleHAiOjE3ODk5ODk1NzR9.fV7Z0zkDyaA9jWTjFymawvixJyzWuf6MYnCDuBlkqRs	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-21 11:19:34.546	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.168.32	2026-09-14 11:19:34.547
cmtz6c531002xc63vh0danfpm	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MjY1MjU4LCJleHAiOjE3ODk4NzAwNTh9.eI7D13d68zrB9OSRuuROC4jFWfTzWtQUT-9Op9IZirA	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-20 02:07:38.173	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	104.22.14.112	2026-09-13 02:07:38.174
cmtztni1b003fc63vffqb7zm1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXR6dG5pMDcwMDNkYzYzdjN3aXduYWcxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MzA0NDE5LCJleHAiOjE3ODk5MDkyMTl9.IDVoJiYG1qaH5nCjjBatY2tUM54HRuYFVHJVp6J_ByQ	cmtztni07003dc63v3wiwnag1	CUSTOMER	2026-09-20 13:00:19.342	okhttp/4.12.0	e0d0bfa7a0521f97	vivo 1906	11	162.158.170.73	2026-09-13 13:00:19.343
cmu012662003mc63vcp28z2fi	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXUwMTI2NXYwMDNrYzYzdmluOGprcW80Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MzE2ODYxLCJleHAiOjE3ODk5MjE2NjF9.m9PFoRusaDe6zyJOHdTlPai-1B46tPTv-dh2TrTLD90	cmu01265v003kc63vin8jkqo4	CUSTOMER	2026-09-20 16:27:41.113	okhttp/4.12.0	6853e0297616a5db	CPH2785	16	172.69.122.164	2026-09-13 16:27:41.114
cmu01cu1l003tc63vq2zmg6uh	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXUwMWNxNncwMDNxYzYzdjF2YTd2ZWVvIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTMxNzM1OCwiZXhwIjoxNzg5OTIyMTU4fQ.Wr5hV3cN3D-aclSoxQKogXfzxizSldsJ_almBp3npeI	cmu01cq6w003qc63v1va7veeo	VENDOR	2026-09-20 16:35:58.617	okhttp/4.12.0	6853e0297616a5db	CPH2785	16	172.69.122.165	2026-09-13 16:35:58.618
cmu01cyxx003uc63vmbu6axjm	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXUwMTI2NXYwMDNrYzYzdmluOGprcW80Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MzE3MzY0LCJleHAiOjE3ODk5MjIxNjR9.tVfbRyI41qCe9sz3HCQmSe_qbCLG_dA-RMKLSd1eZaE	cmu01265v003kc63vin8jkqo4	CUSTOMER	2026-09-20 16:36:04.964	okhttp/4.12.0	6853e0297616a5db	CPH2785	16	172.69.122.165	2026-09-13 16:36:04.965
cmu01d7k2003vc63vttte94ge	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXUwMWNxNncwMDNxYzYzdjF2YTd2ZWVvIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTMxNzM3NiwiZXhwIjoxNzg5OTIyMTc2fQ.oLE9iMoDa6XpHagYM-nOtlNJUnEybG5o6DzxwT6IW1k	cmu01cq6w003qc63v1va7veeo	VENDOR	2026-09-20 16:36:16.13	okhttp/4.12.0	6853e0297616a5db	CPH2785	16	172.69.122.165	2026-09-13 16:36:16.131
cmu0jivwy003wc63v6cxahs64	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MzQ3ODc0LCJleHAiOjE3ODk5NTI2NzR9.loK95wzkvPpEFKsTsr-dCjuHA8JFvpxAvGl_II7_9wQ	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-21 01:04:34.063	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	172.71.99.181	2026-09-14 01:04:34.066
cmu0khuis003xc63vcbdn4dlf	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MzQ5NTA1LCJleHAiOjE3ODk5NTQzMDV9.r0atucXMZWsmqabMe2RXxvpQkH6TKavHKCbHboYRNSM	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-21 01:31:45.219	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	104.22.14.112	2026-09-14 01:31:45.22
cmu0qc0rp0042c63vnj2iuzpj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXUwcWMwcG4wMDQwYzYzdnF4c3lxZncwIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MzU5MzExLCJleHAiOjE3ODk5NjQxMTF9.8xghlq2JBDl0a-61nk5nfCw5TWImGR01vsmwLCldvUE	cmu0qc0pn0040c63vqxsyqfw0	CUSTOMER	2026-09-21 04:15:11.076	okhttp/4.12.0	8cc4c042f2c66e8b	V2437	16	141.101.76.55	2026-09-14 04:15:11.077
cmu0sv37f0043c63vbru4mais	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5MzYzNTU5LCJleHAiOjE3ODk5NjgzNTl9.V2YiCadqtjrXvTwJKDiyTjSpOPRnU_BTa6AcivtywLA	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-21 05:25:59.931	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	172.68.55.202	2026-09-14 05:25:59.932
cmu0sv6s80044c63veyg6ngy3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTM2MzU2NCwiZXhwIjoxNzg5OTY4MzY0fQ.Jd13-ea2jiK3uyTFhP-iEK272WparMUGHGFDiLyqir8	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-21 05:26:04.568	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	172.68.55.202	2026-09-14 05:26:04.569
cmu12489j0048c63vx2oiagsv	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXUxMjQ4OHEwMDQ2YzYzdmZvYWx3MHZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5Mzc5MTAyLCJleHAiOjE3ODk5ODM5MDJ9.AGWf7qs3gYyTcdf_Dm-VKtOvB03O5-xLH29J4w9ca28	cmu12488q0046c63vfoalw0vq	CUSTOMER	2026-09-21 09:45:02.934	okhttp/4.12.0	a9756360c0f60ed4	CPH2467	15	162.158.88.138	2026-09-14 09:45:02.935
cmu13efo30049c63vkjszpw6w	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5MzgxMjU4LCJleHAiOjE3ODk5ODYwNTh9.jU4T4-7tH0JZeeYosrxvIyGBkVIByHuw9pezMbigeTI	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-21 10:20:58.707	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	162.159.98.218	2026-09-14 10:20:58.707
cmu153ny60000c644lx6fadtb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5Mzg0MTE1LCJleHAiOjE3ODk5ODg5MTV9.acLLXsJvuUr5YACa1aXYR9xWuw132Ip4K-STsnQ1NWo	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-21 11:08:35.453	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	\N	\N	\N	172.71.218.226	2026-09-14 11:08:35.455
cmu15c1qf0002c644y7nw1gsx	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5Mzg0NTA2LCJleHAiOjE3ODk5ODkzMDZ9.34U_vtra-8ObZix-QPrui9NDUp_SfqYLBllcE8IpZ7g	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-21 11:15:06.567	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.159.99.64	2026-09-14 11:15:06.567
cmu15c6d90003c6446t8wjwqg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTM4NDUxMiwiZXhwIjoxNzg5OTg5MzEyfQ.islPu3iqTWu_33WPusGcABExR1HbNhfZX0rMSFTwc9w	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-21 11:15:12.572	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.159.99.64	2026-09-14 11:15:12.573
cmu15f0ke0004c644l769tv98	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5Mzg0NjQ1LCJleHAiOjE3ODk5ODk0NDV9.AM5G2XgovD2_H5rk2SDFaFMD8Fp33XaHRwJT07kkGIM	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-21 11:17:25.022	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.170.189	2026-09-14 11:17:25.023
cmu15f7sd0005c644ctbvhcmm	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTM4NDY1NCwiZXhwIjoxNzg5OTg5NDU0fQ.pzW4jIkOEZXiCzjGsvZQPSmasePGJNy7E-Tw7-vI6Ho	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-21 11:17:34.381	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.170.33	2026-09-14 11:17:34.381
cmu15fhlq0006c6440kzblh87	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5Mzg0NjY3LCJleHAiOjE3ODk5ODk0Njd9.zjxJ-22YmCv5zE-hdY4JjRQWoIcVggzGN2hZ1N1QtuQ	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-21 11:17:47.101	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.166.159	2026-09-14 11:17:47.102
cmu15knmw0009c644wpgsyvyk	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTM4NDkwOCwiZXhwIjoxNzg5OTg5NzA4fQ.CpyCmklwg8Ajc-DtCZa4ccaEdUIzm20huvgG6JS4DkM	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-21 11:21:48.2	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.168.32	2026-09-14 11:21:48.201
cmu15ynjc000bc644nptt3gy3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTM4NTU2MSwiZXhwIjoxNzg5OTkwMzYxfQ.4QRKW1cMHGaYZ8NBPLjRE2cnWvo5uarfhBNc8R2ryDk	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-21 11:32:41.255	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.23.166.110	2026-09-14 11:32:41.257
cmu15ypuf000cc644q9hxadrg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5Mzg1NTY0LCJleHAiOjE3ODk5OTAzNjR9.ePdvwX57APdrjgF2-c6bpX8AX0C1B4EyQtDopa8pL-c	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-21 11:32:44.247	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.23.166.110	2026-09-14 11:32:44.248
cmu15z91p000dc644w94mtdml	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5Mzg1NTg5LCJleHAiOjE3ODk5OTAzODl9.hjLrCRoe_hWBlaDggExuHUwPb0jCekD609pedhcPtI0	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-21 11:33:09.132	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-14 11:33:09.133
cmu15zluk000ec6440h9jxne4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTM4NTYwNSwiZXhwIjoxNzg5OTkwNDA1fQ.sP19dDq1B_5-vH-SDU6BcvKbcWcT1u9opJai5mACpVg	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-21 11:33:25.724	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-14 11:33:25.724
cmu16hzxo000ic644usf2qtky	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5Mzg2NDYzLCJleHAiOjE3ODk5OTEyNjN9.7-z3KZko6OUixqTmIH_juZdeoOUqLz3wAlmA4ESE1U0	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-21 11:47:43.788	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	172.71.99.181	2026-09-14 11:47:43.789
cmu26ie5o000mc644grw6uf5l	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXUyNmllNWIwMDBrYzY0NHNiejVzbmluIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NDQ2OTQ4LCJleHAiOjE3OTAwNTE3NDh9.XB1ScjQrsL2srpUiDg5_wx-HnWlw1O_AP2EUgYm2U5M	cmu26ie5b000kc644sbz5snin	CUSTOMER	2026-09-22 04:35:48.395	okhttp/4.12.0	f9766b2217212d3a	CPH2827	15	172.68.55.202	2026-09-15 04:35:48.396
cmu28je73000pc6443xm29ctc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXUyOGplNngwMDBuYzY0NDlvYzVmMjVqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NDUwMzU0LCJleHAiOjE3OTAwNTUxNTR9.66COcIUk-dNMB0RwcCjche2FwbIc0uYVPh1GugGgmX8	cmu28je6x000nc6449oc5f25j	CUSTOMER	2026-09-22 05:32:34.335	okhttp/4.12.0	1beb3305fb5e85d4	I2405	16	162.159.99.64	2026-09-15 05:32:34.335
cmu28pbxf000xc644eu7cwu10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXUyOHBieDUwMDB2YzY0NG1uNjZrdTB4Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NDUwNjMxLCJleHAiOjE3OTAwNTU0MzF9.jWjpQV6f9x9kpye06Iw0mAkw0QFK6JIGFAL3gCS1nHw	cmu28pbx5000vc644mn66ku0x	CUSTOMER	2026-09-22 05:37:11.331	okhttp/4.12.0	60e4f947a6c8cf1b	CPH2763	16	172.70.93.108	2026-09-15 05:37:11.332
cmu28tfr90010c644eledc62k	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5NDUwODIyLCJleHAiOjE3OTAwNTU2MjJ9.QQICuk8-17fUJmziplGBuRxpsmto5gtau7jHYzqp-5I	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-22 05:40:22.916	Mozilla/5.0 (Linux; Android 15; V2303) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/16.3.6.1	\N	\N	\N	104.22.14.112	2026-09-15 05:40:22.917
cmu2a68tu0013c6442zmpae0o	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5NDUzMTAwLCJleHAiOjE3OTAwNTc5MDB9.1RUQZeRH9jdK6rwxNGYA3c3YxImABTGxKssk52d1pbY	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-22 06:18:20.081	Mozilla/5.0 (Linux; Android 15; V2303) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/16.3.6.1	\N	\N	\N	172.68.55.202	2026-09-15 06:18:20.082
cmu2qc0dg0014c644d9tj1p8r	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvYjg5Mm0wMDN4YzZxbnFobXhwOGx1Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NDgwMjQyLCJleHAiOjE3OTAwODUwNDJ9.rmPdEpwV35DNiFMK4V8woIxkG9C-Qc82mkZOBbD_Rmo	cmtob892m003xc6qnqhmxp8lu	CUSTOMER	2026-09-22 13:50:42.915	okhttp/4.12.0	3d3d24c34f733e48	V2545	16	162.158.107.61	2026-09-15 13:50:42.916
cmu5s6roz001fc644dgli1zp3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXU1czZybnEwMDFkYzY0NG9kY2t6bWZqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NjY0NzU2LCJleHAiOjE3OTAyNjk1NTZ9.MUZhYNVeMAZCqID5ixm-XHzujHikBAuR6Rtszi6_vgg	cmu5s6rnq001dc644odckzmfj	CUSTOMER	2026-09-24 17:05:56.146	okhttp/4.12.0	c41cb2484ad75a4b	V2025	13	104.23.175.82	2026-09-17 17:05:56.148
cmu6bthny001uc644mcyc8gtj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5Njk3NzI4LCJleHAiOjE3OTAzMDI1Mjh9.eU-1Lcwo0v2Fcmc03w_kE7b8GcMbhpYJPrMtnlSy4vU	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-25 02:15:28.941	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	162.159.99.64	2026-09-18 02:15:28.942
cmu6chg8b001xc6448zlc1jb7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXU2Y2hnODEwMDF2YzY0NHE3YTVpMTM0Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5Njk4ODQ2LCJleHAiOjE3OTAzMDM2NDZ9.2D3BvjioZqslhGga17f3Y4pRZqaCQgE8AojRYrzRaAc	cmu6chg81001vc644q7a5i134	CUSTOMER	2026-09-25 02:34:06.827	okhttp/4.12.0	a7c9e99ed78d0f16	vivo 1951	11	172.68.242.3	2026-09-18 02:34:06.827
cmu6ckaul002bc644v2cpqhfn	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXU2Y2thdWYwMDI5YzY0NDVmenlpaWhmIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5Njk4OTc5LCJleHAiOjE3OTAzMDM3Nzl9.0M5D_l9SErw4mXoBJYaz6wb86iutHG_jipBHDnHyGBI	cmu6ckauf0029c6445fzyiihf	CUSTOMER	2026-09-25 02:36:19.821	okhttp/4.12.0	b9fa1a68005d27b3	CPH2375	13	172.70.208.2	2026-09-18 02:36:19.822
cmu6f9b5z002ic644yorvqogy	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5NzAzNTA1LCJleHAiOjE3OTAzMDgzMDV9.MFL30hOJVcJ_odLCwK03KPH8JOM0pFK6bBLd0oQDKCY	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-25 03:51:45.863	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	172.68.164.26	2026-09-18 03:51:45.864
cmu6faqca002pc6449x1bqf4x	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzAzNTcyLCJleHAiOjE3OTAzMDgzNzJ9.krUEuBFpy0Mq037htK0n8__Uk9dlgbO_7ETf2N0ymig	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-25 03:52:52.185	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.172.60	2026-09-18 03:52:52.186
cmu6ffqzc002sc644k0hxpak5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcwMzgwNiwiZXhwIjoxNzkwMzA4NjA2fQ.CQMpkd-TpdWEdPE2G_cbj1za3VswqSKjwLJESqMg3Go	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-25 03:56:46.296	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	141.101.76.159	2026-09-18 03:56:46.297
cmu6fg9og002tc64424baylfa	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzAzODMwLCJleHAiOjE3OTAzMDg2MzB9.6yc9LEFctjTzZpkjut18B_SwHxMenE_lI8A4Owtqy3c	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-25 03:57:10.528	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	141.101.76.54	2026-09-18 03:57:10.529
cmu6fgccj002uc644jk3bfnjp	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcwMzgzMywiZXhwIjoxNzkwMzA4NjMzfQ.ix8_Ft4Q7Vrv7Zj_kEegYajjcjSxCj4_EpLjpO-tTm8	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-25 03:57:13.987	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	141.101.76.55	2026-09-18 03:57:13.988
cmu6hu1zh002vc644vjtboaiq	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5NzA3ODMyLCJleHAiOjE3OTAzMTI2MzJ9.LWSdQUTtoaIwcsebvl8Jd4iy722wjpdnYna3Ee0k454	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-25 05:03:52.972	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	172.70.142.25	2026-09-18 05:03:52.973
cmu6ijs8i002wc6447lg3kzj9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5NzA5MDMzLCJleHAiOjE3OTAzMTM4MzN9.fB4Ttha4s2iUCkJQ5HCRDUlbHUi2z-RZlm_YWtz--H8	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-25 05:23:53.393	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	172.71.124.106	2026-09-18 05:23:53.394
cmu6ilhvc002xc644rcm0oguz	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzA5MTEzLCJleHAiOjE3OTAzMTM5MTN9.22isAa12onX76ur5VCDhAcF6mdn_HJXZuoG0GaIjzL8	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-25 05:25:13.272	okhttp/4.12.0	37c0c246503697b8	V2511	16	141.101.76.54	2026-09-18 05:25:13.272
cmu6ilkd5002yc644glqyprai	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcwOTExNiwiZXhwIjoxNzkwMzEzOTE2fQ.G3p-ykgWl8VDcjUQ0IirkswOsruJeG92RI1QjaBtALM	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-25 05:25:16.505	okhttp/4.12.0	37c0c246503697b8	V2511	16	141.101.76.54	2026-09-18 05:25:16.505
cmu6ilm6f002zc644uy8kqfhw	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzA5MTE4LCJleHAiOjE3OTAzMTM5MTh9.see9tb3mdQOCZzTIYtVxL0sUSlkuWKZ0SPJoHpd-GyI	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-25 05:25:18.854	okhttp/4.12.0	37c0c246503697b8	V2511	16	141.101.76.54	2026-09-18 05:25:18.855
cmu6immuh0030c644tecn7xjw	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcwOTE2NiwiZXhwIjoxNzkwMzEzOTY2fQ.SqFANpecJnYH2jPv5hxWtPa9PISzhLswg7zV__B-FvI	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-25 05:26:06.376	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.183.214	2026-09-18 05:26:06.377
cmu6imws60031c644xvy3fthy	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzA5MTc5LCJleHAiOjE3OTAzMTM5Nzl9.OsJKuOL9TyeqbaC-GlVh5CztOqH_-Q4_Hd1KWCoL3pk	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-25 05:26:19.254	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.183.214	2026-09-18 05:26:19.255
cmu6imy790032c644ec289ndb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcwOTE4MSwiZXhwIjoxNzkwMzEzOTgxfQ.Tdht-cKfBE4DCeSIu846bmrVqtv09YASqUsqxVPmgMw	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-25 05:26:21.092	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.183.214	2026-09-18 05:26:21.093
cmu6in0nc0033c644xoc1yvyl	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzA5MTg0LCJleHAiOjE3OTAzMTM5ODR9.qkaORKIDJ3qZxWqmzlFUB8VaB0iDI8-YdR7zvIAUKu0	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-25 05:26:24.263	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.183.214	2026-09-18 05:26:24.264
cmu6in2yr0034c644ysw5xpk0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcwOTE4NywiZXhwIjoxNzkwMzEzOTg3fQ.TrkPNi1m4PlcVSpQsCxyZVd8fDHlciMnDFqB1TWtE0U	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-25 05:26:27.266	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.183.214	2026-09-18 05:26:27.267
cmu6in4z80035c644s5ounsom	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzA5MTg5LCJleHAiOjE3OTAzMTM5ODl9.mAvOEuZiwjfCHR9TKLXNjUgsb0fPgXDwBq2XLtmXFo0	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-25 05:26:29.876	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.183.214	2026-09-18 05:26:29.876
cmu6in70z0036c644t8mnth15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcwOTE5MiwiZXhwIjoxNzkwMzEzOTkyfQ.lBrzpYzsLbwABoinWjuU26caDBp7Lpgb3DOAlmHuLWA	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-25 05:26:32.53	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.183.214	2026-09-18 05:26:32.531
cmu6inbej0037c644n6euwfmk	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzA5MTk4LCJleHAiOjE3OTAzMTM5OTh9.1E9fuRXBrXOhM3DVXGf47l8s2kIFNBz_UObKsjmE5_c	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-25 05:26:38.202	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.183.214	2026-09-18 05:26:38.203
cmu6incwk0038c644ju8lxp13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcwOTIwMCwiZXhwIjoxNzkwMzE0MDAwfQ.FVL_pG_FqrqL9exzjOoO8ObX1qSngfZhbi4QU3AZshI	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-25 05:26:40.147	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.183.214	2026-09-18 05:26:40.148
cmu6injs80039c644we19z20p	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzA5MjA5LCJleHAiOjE3OTAzMTQwMDl9.z3hc8wMTXl4xydEqHyXel9mZZxgtmcxf9ZdaaGXZEs8	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-25 05:26:49.064	okhttp/4.12.0	37c0c246503697b8	V2511	16	162.159.113.34	2026-09-18 05:26:49.065
cmu6l1utj003dc644gqyeb9c5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXU2bDF1c3UwMDNiYzY0NHY1bmN3M2duIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzEzMjM1LCJleHAiOjE3OTAzMTgwMzV9.gaq67YT3lofkFy8MH1hlY61kVPpiViu4rGNfnyQ08i0	cmu6l1usu003bc644v5ncw3gn	CUSTOMER	2026-09-25 06:33:55.783	okhttp/4.12.0	67d86e7ee1bc704f	V2545	16	104.22.14.112	2026-09-18 06:33:55.784
cmu6q47f4003ec644vct9o810	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcyMTc0MywiZXhwIjoxNzkwMzI2NTQzfQ.X-mRSx1_qSczxsL1xh3Xk7cIMzX_3BKacCnP8KXikPc	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-25 08:55:43.503	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.69.224.130	2026-09-18 08:55:43.504
cmu6q4d0c003fc644g1eyuwsx	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzIxNzUwLCJleHAiOjE3OTAzMjY1NTB9.13IR5hXABu76qdbx9x2Iew3HaRVVfKC6hp-_rurJaqc	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-25 08:55:50.748	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.69.224.130	2026-09-18 08:55:50.749
cmu6qngn7003ic64413ao79en	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXU2cW5nbXMwMDNnYzY0NHF1Y21zemNzIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzIyNjQxLCJleHAiOjE3OTAzMjc0NDF9.uhIU-5tD5FVn01JV330FMQ5gnvAEkwPiGWlUwn1x6P4	cmu6qngms003gc644qucmszcs	CUSTOMER	2026-09-25 09:10:41.923	okhttp/4.12.0	293a954f65d6b29e	V2403	14	172.68.186.135	2026-09-18 09:10:41.923
cmu6s4kxm003mc644y94xob0i	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzI1MTIwLCJleHAiOjE3OTAzMjk5MjB9.jGhkyAyhP6DpjHX5fMSxRapGCODfiVmXUqiCI92_mb0	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-25 09:52:00.25	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.159.99.64	2026-09-18 09:52:00.251
cmu6s4nb3003nc6447au8q9eq	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcyNTEyMywiZXhwIjoxNzkwMzI5OTIzfQ.fiKQClxl3jz0-OzaqbtzEtZJml1UFU_Z_-BmhA1fyAA	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-25 09:52:03.327	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.159.99.64	2026-09-18 09:52:03.327
cmu6s4pgv003oc6448r21g0lw	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzI1MTI2LCJleHAiOjE3OTAzMjk5MjZ9.6ldyM2q69kFhUMkumlZNd91frEuAusbyZSwNBppER-0	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-25 09:52:06.127	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.159.99.64	2026-09-18 09:52:06.128
cmu6s52jt003pc64473drbt13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcyNTE0MywiZXhwIjoxNzkwMzI5OTQzfQ.cDgO0yaIWaznQZ6l3CzN9cfOE2fFtrTa6Hv3llq61Bk	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-25 09:52:23.081	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-18 09:52:23.082
cmu6s59h8003qc644nf5wuaz8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzI1MTUyLCJleHAiOjE3OTAzMjk5NTJ9.n_kJ2svniKhKc6OO4Aywh5gbUuxKT4q-6Wzgwt2ePVU	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-25 09:52:32.059	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-18 09:52:32.06
cmu6s5b90003rc644yach9hpx	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcyNTE1NCwiZXhwIjoxNzkwMzI5OTU0fQ.O7upRfhv7WgfY0hjBpYqm7bDIbwOGW3RTe0PeFFYnHA	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-25 09:52:34.356	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-18 09:52:34.357
cmu6sjcz3003sc644v9v6oqil	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcyNTgwOSwiZXhwIjoxNzkwMzMwNjA5fQ.D9HCL8Ob-UrzkSGInqu_q2X0JIM8TF-njuaMx6kSVyI	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-25 10:03:29.774	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-18 10:03:29.775
cmu6trvtp0000c6u6l3j2f5h3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzI3ODg3LCJleHAiOjE3OTAzMzI2ODd9.hjP_7n47MMJZL8yIN9g2fF2zQ-XSDN6nq2O3O7qcwWk	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-25 10:38:07.068	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.99.182	2026-09-18 10:38:07.069
cmu6trxts0001c6u627kvo9nk	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcyNzg4OSwiZXhwIjoxNzkwMzMyNjg5fQ.L3fk0KLGAnkY3bcXtr23K60sIvFbASYmlTAJG_wjmwY	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-25 10:38:09.664	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.98.64	2026-09-18 10:38:09.665
cmu6trzou0002c6u61deimxt0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzI3ODkyLCJleHAiOjE3OTAzMzI2OTJ9.VUusTTm3_825P8tfHjyKl1LWjgGDQRD2aNx69SNXJtg	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-25 10:38:12.078	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.71.98.64	2026-09-18 10:38:12.078
cmu6ts7y20003c6u60gk42j0g	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcyNzkwMiwiZXhwIjoxNzkwMzMyNzAyfQ.lFTJZSJXMsu_HjjmCZk0nDTlu1_sL-j1c54Ci14NgNY	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-25 10:38:22.777	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.23.170.189	2026-09-18 10:38:22.778
cmu6tsxb20004c6u6ylyd9ae7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcyNzkzNSwiZXhwIjoxNzkwMzMyNzM1fQ.7zWsjbebph_uSUEXtqeBZw3MfUq-HkroMCG309EgIfI	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-25 10:38:55.645	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.168.32	2026-09-18 10:38:55.647
cmu6tt2oj0005c6u6dfbw8uhx	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzI3OTQyLCJleHAiOjE3OTAzMzI3NDJ9.ljXBptsR47xfvt7fK88IeXg36PbXjOVq2b9GJn_HySo	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-25 10:39:02.603	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.168.32	2026-09-18 10:39:02.612
cmu6tt4n60006c6u6lldhyfev	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcyNzk0NSwiZXhwIjoxNzkwMzMyNzQ1fQ.ENMh77Q4AUUs65uCKAK8uasreG8lGBn-JqaEF9-sNkQ	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-25 10:39:05.154	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.168.32	2026-09-18 10:39:05.155
cmu6ttdrh0007c6u62tuayez9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzI3OTU2LCJleHAiOjE3OTAzMzI3NTZ9.bUz-ofVIn8KBq7rw7mZddsOE2v5Zh7lrYNzZw-9FLU0	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-09-25 10:39:16.973	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.159.113.80	2026-09-18 10:39:16.974
cmu6ttgsv0008c6u6qxz8zgrq	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTcyNzk2MCwiZXhwIjoxNzkwMzMyNzYwfQ.cfmOTYEzKuN3MlW2Nvf8VOdrkGsQNmJqwGwIaxHksds	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-25 10:39:20.911	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.159.113.34	2026-09-18 10:39:20.912
cmu6yb7r40009c6u6wd5dxh29	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXUwMWNxNncwMDNxYzYzdjF2YTd2ZWVvIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTczNTUwNywiZXhwIjoxNzkwMzQwMzA3fQ.4bEp2AQKCI0FUhkoy2YuYNJgt8qm-yxthWrErdimQnA	cmu01cq6w003qc63v1va7veeo	VENDOR	2026-09-25 12:45:07.455	okhttp/4.12.0	6853e0297616a5db	CPH2785	16	172.69.122.165	2026-09-18 12:45:07.456
cmu6ybrnc000ac6u6g4klyqbh	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXUwMTI2NXYwMDNrYzYzdmluOGprcW80Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzM1NTMzLCJleHAiOjE3OTAzNDAzMzN9.zhbkPjHGbt__x_KhLEIbCujHLeveT3_jdMngbT5b4IQ	cmu01265v003kc63vin8jkqo4	CUSTOMER	2026-09-25 12:45:33.234	okhttp/4.12.0	6853e0297616a5db	CPH2785	16	172.69.122.165	2026-09-18 12:45:33.24
cmu6zionj000dc6u6azjjp3ga	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5NzM3NTM1LCJleHAiOjE3OTAzNDIzMzV9.fuiAQcntwU8zQnEZO_NVZAwagakN0fGLdPr5PxTxxj8	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-25 13:18:55.567	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	162.159.99.64	2026-09-18 13:18:55.567
cmu73iqmx000hc6u6c1biggp0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXU3M2lxbWgwMDBmYzZ1Nnh4OG96aHRwIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzQ0MjU2LCJleHAiOjE3OTAzNDkwNTZ9.wOBD_8pvZ1G_Q4qyrCld7LNm4Lh2uE6CRg9I8K_nFa0	cmu73iqmh000fc6u6xx8ozhtp	CUSTOMER	2026-09-25 15:10:56.6	okhttp/4.12.0	3610aae1d4dc55f0	V2427	16	172.71.152.82	2026-09-18 15:10:56.601
cmu78xtsw000kc6u6w3d252cy	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTc1MzM1OCwiZXhwIjoxNzkwMzU4MTU4fQ.g3Zg0O5E2wJcxYAkwL_XyAIAPfhuKR5RaLqj2v26QLE	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-25 17:42:38.624	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-18 17:42:38.624
cmu78xxdf000lc6u6cbhhnrsl	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5NzUzMzYzLCJleHAiOjE3OTAzNTgxNjN9.lrgiAdRzF6XEfSpVhO5sG1JIiKSb9I60-9lT3kT5Uyg	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-09-25 17:42:43.25	okhttp/4.12.0	37c0c246503697b8	V2511	16	104.22.14.112	2026-09-18 17:42:43.251
cmu7wr8ua000qc6u6wufeyjlq	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTc5MzM2MiwiZXhwIjoxNzkwMzk4MTYyfQ.Zh-FkOOcz_Z-YoZ8BtOuEzrEXuFIiqJemTNiBDF653g	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-26 04:49:22.304	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.158.10.145	2026-09-19 04:49:22.306
cmu7z74eg000rc6u6mo6ozw31	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtb2NseXYwMDIyYzZka3lpNDE1dDhyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5Nzk3NDYyLCJleHAiOjE3OTA0MDIyNjJ9.fUCUp1DUDJ0YijeMgyn6wJBdISwSUnwmHoPKavM4IuI	cmtmoclyv0022c6dkyi415t8r	CUSTOMER	2026-09-26 05:57:42.279	okhttp/4.12.0	5c80fc85daa1040b	V2303	15	172.71.183.214	2026-09-19 05:57:42.28
cmu83fzam000sc6u6mea0em54	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5ODA0NTk0LCJleHAiOjE3OTA0MDkzOTR9.VQX0POUCKRkLlvRnwkWhLi5kCDMNS_6dYSrrEau4jKo	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-26 07:56:34.029	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	162.158.10.145	2026-09-19 07:56:34.031
cmu84yegr000tc6u6hgxjstik	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5ODA3MTMzLCJleHAiOjE3OTA0MTE5MzN9.0_ZuYuetOz6fbEIatPDgdv2qqQ3Y2s75WpMi1DuiNtY	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-26 08:38:53.114	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	104.22.14.112	2026-09-19 08:38:53.115
cmu9r2r9x0013c6u6gwlsozkr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTkwNDc1NCwiZXhwIjoxNzkwNTA5NTU0fQ.mtyYSrZpe4bGRp3TE6gArDkl6zbohTWL1ywUHLx09N4	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-27 11:45:54.065	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-09-20 11:45:54.069
cmu9r5vvq0016c6u62nfoaa70	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXU5cjV2djgwMDE0YzZ1NjhvbWI1b2RhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzg5OTA0OTAwLCJleHAiOjE3OTA1MDk3MDB9.h9pUsxoxP2BhoC6XPx4clq5WvJAuicgYgtfy78bt398	cmu9r5vv80014c6u68omb5oda	CUSTOMER	2026-09-27 11:48:20.006	okhttp/4.12.0	b325ce328c430560	V2437	15	172.71.152.81	2026-09-20 11:48:20.007
cmu9t9c27001bc6u699iuf0ys	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5OTA4NDIwLCJleHAiOjE3OTA1MTMyMjB9.GakZb8FGO7EH0sJSRLcAr873h1ZH7pM7A90SHIJPzGM	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-27 12:47:00.175	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	162.159.99.64	2026-09-20 12:47:00.176
cmuatof25001cc6u6myce5nz6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc4OTk2OTU5MCwiZXhwIjoxNzkwNTc0MzkwfQ.C9Rf8G5oxVimhzoWMwXeOqfPABdGPgu2HCb-BRz6Xng	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-09-28 05:46:30.076	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	172.70.46.41	2026-09-21 05:46:30.078
cmuatqw3d001mc6u6ouw1g9vn	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5OTY5NzA1LCJleHAiOjE3OTA1NzQ1MDV9.rhlWt6lpn1WFckgQ1_Wdt20DlH0xuCzOUihisU_QnZw	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-28 05:48:25.465	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	162.159.99.64	2026-09-21 05:48:25.466
cmuazmlp8001tc6u6dm9jx0u8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5OTc5NTgzLCJleHAiOjE3OTA1ODQzODN9.0nAaBi2z2s_n9jYPk0wvoy9Hi-5SbmvbSswP26XOXcg	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-28 08:33:03.063	Mozilla/5.0 (Linux; Android 15; V2303) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/16.3.6.1	\N	\N	\N	172.71.182.167	2026-09-21 08:33:03.068
cmub8relz001uc6u6c1xhi0yw	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzg5OTk0OTIzLCJleHAiOjE3OTA1OTk3MjN9.e-rUspfuxHX8SFBmmueT271pXnIv7BZfJf_c3tcO5G8	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-28 12:48:43.701	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	104.22.14.112	2026-09-21 12:48:43.703
cmuce73bf002bc6u6w8yhx2u0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MDA2NDUxOSwiZXhwIjoxNzkwNjY5MzE5fQ.JSENvZ7ZSoOler-_bwq2qJvy32QyPtyXUka53MH_oak	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-09-29 08:08:39.818	okhttp/4.12.0	37c0c246503697b8	V2511	16	172.70.46.40	2026-09-22 08:08:39.819
cmuceiam2002cc6u6n70zk2vy	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwMDY1MDQyLCJleHAiOjE3OTA2Njk4NDJ9.p0YRK9tWa5Etj4yE3vhEVzfi0QL60I1mO-YghL57XSw	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-29 08:17:22.489	Mozilla/5.0 (Linux; Android 15; V2303) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/16.3.6.1	\N	\N	\N	104.22.14.112	2026-09-22 08:17:22.49
cmudabftk002wc6u61m2dfhkb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwMTE4NDcwLCJleHAiOjE3OTA3MjMyNzB9.UmyzNM9Uz78Rl33RWOmsNDPPRxghacGuXToNtNXNUW0	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-09-29 23:07:50.357	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36	\N	\N	\N	162.159.99.64	2026-09-22 23:07:50.36
cmughb0080031c6u6auo1wxl8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwMzExNjA1LCJleHAiOjE3OTA5MTY0MDV9.eZqUtHGvyErfPvTi6CxL2JwSOP4zv11iprtjUc_4DuM	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-02 04:46:45.702	Mozilla/5.0 (Linux; Android 15; V2303) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/16.5.2.0	\N	\N	\N	172.68.54.124	2026-09-25 04:46:45.704
cmugu0jmx0034c6u6dsvy3y9g	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwMzMyOTUyLCJleHAiOjE3OTA5Mzc3NTJ9.mQN_4kgLfWIsKcXNDUjM-pWBBNJDzwH005C5-cI0p0k	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-02 10:42:32.936	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	162.158.10.145	2026-09-25 10:42:32.937
cmugu1i6a0035c6u6f17n1dyz	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwMzMyOTk3LCJleHAiOjE3OTA5Mzc3OTd9.kwaW2bHnhMjBFFUjYawlQ9KGkMml4ghwZD1qExwJ_ms	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-10-02 10:43:17.698	okhttp/4.12.0	37c0c246503697b8	V2511	16	162.158.10.145	2026-09-25 10:43:17.698
cmugu1n7u0036c6u6xuz0m9cc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MDMzMzAwNCwiZXhwIjoxNzkwOTM3ODA0fQ._xOsZ0xUhfW74P7k-lv_ku7gD3YxF4NMLzlPiUYc2n4	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-10-02 10:43:24.234	okhttp/4.12.0	37c0c246503697b8	V2511	16	162.158.10.145	2026-09-25 10:43:24.235
cmugu20u70037c6u6xij1tww4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwMzMzMDIxLCJleHAiOjE3OTA5Mzc4MjF9.306WW7Ly1pbE65d-qvSQRqrBLgkK6JbzVtHswPX--VU	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-10-02 10:43:41.886	okhttp/4.12.0	37c0c246503697b8	V2511	16	162.158.10.145	2026-09-25 10:43:41.887
cmun5muv30005c6uvhu3zqrb8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzE1MjY2LCJleHAiOjE3OTEzMjAwNjZ9.2_Z-dC4ofBVSc0_x1A7PF9Y_a9H8PeChEYY3YMHtods	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-06 20:54:26.749	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	162.158.10.145	2026-09-29 20:54:26.751
cmuno5h3u000ac6uvapbvvkvd	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVubzVoMncwMDA4YzZ1dmtuNG05aDYwIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwNzQ2MzY4LCJleHAiOjE3OTEzNTExNjh9.VUhaY5y2ZYijkfxBF7ce7L4Qm4KdW7F3yVR7X4Qcz1Y	cmuno5h2w0008c6uvkn4m9h60	CUSTOMER	2026-10-07 05:32:48.472	okhttp/4.12.0	7d596b709fda74cf	RMX3933	14	172.70.208.3	2026-09-30 05:32:48.474
cmunpgf490013c6uvvbwi2dtj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzQ4NTU4LCJleHAiOjE3OTEzNTMzNTh9.nf4YQC0hyIBIWd72qfN_llDxz_W8CE3YJYxhGNVTSUo	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 06:09:18.729	Mozilla/5.0 (Linux; Android 15; V2303) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/16.5.2.0	\N	\N	\N	162.158.10.145	2026-09-30 06:09:18.73
cmunpkdvp0017c6uvizywmyot	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVucGtkdmgwMDE1YzZ1djh6MnVxb3V6Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwNzQ4NzQzLCJleHAiOjE3OTEzNTM1NDN9.W26hYdvyvB1mchbJHYZgMdlb1sVE-uJmALX9e4NlvAU	cmunpkdvh0015c6uv8z2uqouz	CUSTOMER	2026-10-07 06:12:23.748	okhttp/4.12.0	d6bf22c21fea840e	V2576	16	104.22.14.112	2026-09-30 06:12:23.749
cmunq40150018c6uvtrhk3rzo	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzQ5NjU4LCJleHAiOjE3OTEzNTQ0NTh9.A7iQwMrsXBBI-rl_CIDhPy9_hhgUPmbSaDXQReKn-Qk	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 06:27:38.921	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36	\N	\N	\N	104.22.14.112	2026-09-30 06:27:38.922
cmunq4vdj0019c6uv7cl0hnfu	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzQ5Njk5LCJleHAiOjE3OTEzNTQ0OTl9.jkdbDFoGAedEafZZVRqqLO5YSLg8upa7IVt0jKf0pMQ	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 06:28:19.542	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.71.210.221	2026-09-30 06:28:19.543
cmunq5sb0001bc6uv2qrzdnih	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MDc0OTc0MiwiZXhwIjoxNzkxMzU0NTQyfQ._bEL-tAgLpHgbGMcvewbfwUvL0IuivX8edvan5xhDG8	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-10-07 06:29:02.22	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	162.158.10.145	2026-09-30 06:29:02.22
cmunq604e001cc6uvux26e2tp	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtcmwzM3AwMDI3YzZka250NWg2eGZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwNzQ5NzUyLCJleHAiOjE3OTEzNTQ1NTJ9.7Gly25NplpUdyxMWOhhmM1sPobbBW-yu8AUSnBlDJJU	cmtmrl33p0027c6dknt5h6xfq	CUSTOMER	2026-10-07 06:29:12.35	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	162.158.10.145	2026-09-30 06:29:12.351
cmunq6yc7001nc6uvq6uabwpp	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzQ5Nzk2LCJleHAiOjE3OTEzNTQ1OTZ9.7ua1suQo_QvzEqBNSgF3JoHWs28xYwkyFnd8huE97Qg	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 06:29:56.694	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	108.162.226.195	2026-09-30 06:29:56.695
cmunr7hgr001pc6uvpxepw5zb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MDc1MTUwMSwiZXhwIjoxNzkxMzU2MzAxfQ.mtd9bWR4uZxUg_vTmKIYpvbout13kEGEMWERE-aiOlg	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-10-07 06:58:21.099	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.158.10.145	2026-09-30 06:58:21.1
cmunr7nhq001qc6uvc3amtf9f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwNzUxNTA4LCJleHAiOjE3OTEzNTYzMDh9.d8bCEHc4sM-cdc6p93bF7d5wANKBVogTYcxlLrNKdX8	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-10-07 06:58:28.91	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.158.10.145	2026-09-30 06:58:28.91
cmunrdjsa001zc6uvocw5q528	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzUxNzg0LCJleHAiOjE3OTEzNTY1ODR9.FcbD9hUBt-48hE6-u--FkAURbSZ5yHaAuByGA2B52LA	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 07:03:04.041	node	\N	\N	\N	172.71.210.220	2026-09-30 07:03:04.042
cmunrecwb0024c6uv4ln1dtzl	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzUxODIxLCJleHAiOjE3OTEzNTY2MjF9.nNzGCpuqbU1duFPkbLMLumBQ9YKLriWsRyuOPWLnZeE	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 07:03:41.77	node	\N	\N	\N	172.71.210.220	2026-09-30 07:03:41.771
cmunrn3h3002bc6uvj7k52mom	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MDc1MjIyOSwiZXhwIjoxNzkxMzU3MDI5fQ.bap5MBsDef2lf-6V6qn6cauZJFhVWFdclCRz4TjOlMw	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-10-07 07:10:29.463	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.23.168.32	2026-09-30 07:10:29.464
cmunror73002cc6uv5b0zjot6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzUyMzA2LCJleHAiOjE3OTEzNTcxMDZ9.UFTEIZnUfKwZeKg9xo15UuTkt_iu9kyZsyyEcg99RDM	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 07:11:46.862	node	\N	\N	\N	162.159.98.219	2026-09-30 07:11:46.863
cmuntt6p80005c683oa58tfwb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVudHJ3ODcwMDAzYzY4M3cwcHdjcjhiIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MDc1NTg3MiwiZXhwIjoxNzkxMzYwNjcyfQ.vbbUlFk5VWd9vzL4h7MB4TDzWdXoJpryirTlJmr1zkI	cmuntrw870003c683w0pwcr8b	VENDOR	2026-10-07 08:11:12.812	okhttp/4.12.0	37c0c246503697b8	V2511	16	162.159.113.35	2026-09-30 08:11:12.813
cmunttdy70006c683mgji415r	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVudHJ3NW8wMDAwYzY4M21sOWpxZDFsIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwNzU1ODgyLCJleHAiOjE3OTEzNjA2ODJ9.OPvDp6fQlUe8XWxQDLND7eoosbFfQR_jxp45oP3qZ10	cmuntrw5o0000c683ml9jqd1l	CUSTOMER	2026-10-07 08:11:22.207	okhttp/4.12.0	37c0c246503697b8	V2511	16	162.159.113.35	2026-09-30 08:11:22.208
cmunvm4aw0007c683u1yj6kti	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzU4OTAyLCJleHAiOjE3OTEzNjM3MDJ9.4Tbz-__PZptrDSD69mzp-dbOhQI6Jv2IpET36nQ79AM	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 09:01:42.344	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	162.158.163.223	2026-09-30 09:01:42.345
cmunw7lqn0000c6h034b9qzs6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzU5OTA0LCJleHAiOjE3OTEzNjQ3MDQsImp0aSI6ImMzZmNlOTljLTI4ZjQtNGIyOS1iNzM0LTdjODUwZWQ1MzMyZiJ9.HugCfPaa3WwcnPuxbmpq5w7j-rWMekQE0OQ9YeBdlbM	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 09:18:24.718	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	162.158.108.75	2026-09-30 09:18:24.719
cmunxocwn0003c6h0sq5rgyta	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzYyMzY2LCJleHAiOjE3OTEzNjcxNjYsImp0aSI6IjExYmY5M2NkLWQ3MmUtNGY5NS05YzhjLTIzZDBkODE2OGUzZSJ9.lRYGckn8Y_x3v6SXFRUEF-_GOpSB1Gnu6m6wPH90I70	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 09:59:26.038	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	162.158.193.221	2026-09-30 09:59:26.039
cmunxr3de0004c6h0ysycs07r	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvNmhwNDEwMDFpYzZxbm9mbTM3cnc1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MDc2MjQ5MywiZXhwIjoxNzkxMzY3MjkzLCJqdGkiOiI2NWI0YjgzOC0zMWU3LTQ5MmQtOTc0NS02MjU0ZTlkZjJmMWEifQ.OYywtsaf_RToc_6XQ34XwEreOeEC8vQoNRB7mCFeaIg	cmto6hp41001ic6qnofm37rw5	VENDOR	2026-10-07 10:01:33.65	okhttp/4.12.0	bcdc1c6e1498974b	I2403	16	172.70.46.41	2026-09-30 10:01:33.65
cmunygek60005c6h0uaz16eh3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzYzNjc0LCJleHAiOjE3OTEzNjg0NzQsImp0aSI6IjI0OWE3NDY2LWY5NWYtNDEzNS1iMTM1LTlkNjE2NWFkNDNlZCJ9.Q0oQ_O0qHPuzpKMyJ0o5U2xiMFUF0S8xPMup5iDOOO4	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 10:21:14.55	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.71.218.226	2026-09-30 10:21:14.551
cmunyl8cf0000c6i7lczk9fn0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzYzODk5LCJleHAiOjE3OTEzNjg2OTksImp0aSI6ImI4ZjY0ZjcyLWM3MWUtNDA1Yy04OWI5LWM1ZDYzYzEwN2Q3YSJ9.0m-OdEg8vmlNzgeQuxpMqNh-LVEJMgJ8EoXsIvxTar8	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 10:24:59.774	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.70.208.3	2026-09-30 10:24:59.775
cmuo08xoc0001c6i7vnrni0qm	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzY2Njg1LCJleHAiOjE3OTEzNzE0ODUsImp0aSI6IjRjZmJjODNiLTA0ODQtNDgxMi1hNjEzLTdkNmQ2ZDcxMGM1NSJ9.hfqRZNtZNlWetUGLdSaEfbZfkRpkcnPF04Zpn_ovDTM	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 11:11:25.308	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.70.142.211	2026-09-30 11:11:25.309
cmuo0i10z0003c6i7683trh1y	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtb2NseXYwMDIyYzZka3lpNDE1dDhyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwNzY3MTA5LCJleHAiOjE3OTEzNzE5MDksImp0aSI6ImM5MDIxMDc2LThkY2MtNGM0YS1iOTQxLTU5MGM5OWE1NzYxNCJ9.g5DBPwAyN-pBxBbl7K_XFHFOwVBrY6ZlWN592KCp5nA	cmtmoclyv0022c6dkyi415t8r	CUSTOMER	2026-10-07 11:18:29.554	okhttp/4.12.0	5c80fc85daa1040b	V2303	15	104.22.14.112	2026-09-30 11:18:29.556
cmuo0kh7j0004c6i7g9j0jwb5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzY3MjIzLCJleHAiOjE3OTEzNzIwMjMsImp0aSI6ImM4N2YzNTg3LWU2MjUtNGE5OC1hZjY3LWY3YzIzNTVkMDRlOSJ9.tUCHNAooQYAErAFHV3fY2jh5-_zsJH8Ir7Mgkpc6dLM	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 11:20:23.839	Mozilla/5.0 (Linux; Android 15; V2303) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/16.5.2.0	\N	\N	\N	162.158.10.145	2026-09-30 11:20:23.84
cmuo0uktf0007c6i7fo9435i1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMG1mNGIwMDA2YzZpN2M5d25la2Q5Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MDc2NzY5NSwiZXhwIjoxNzkxMzcyNDk1LCJqdGkiOiJiNDJiZDEwOC04YTcwLTRlYTQtOTIzMy0xODY1Y2EyMzM2YzQifQ.1CAT_fbLh2aes1iwQRyl_VhgGm-yREVCUW3sL9IWNU0	cmuo0mf4b0006c6i7c9wnekd9	VENDOR	2026-10-07 11:28:15.074	okhttp/4.12.0	7d596b709fda74cf	RMX3933	14	172.68.225.142	2026-09-30 11:28:15.075
cmuo1422z000cc6i75lecu6t0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVubzVoMncwMDA4YzZ1dmtuNG05aDYwIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwNzY4MTM3LCJleHAiOjE3OTEzNzI5MzcsImp0aSI6IjliZjE0YjNiLWNkMGYtNGY4Zi04MGVlLWU0NjQ0MDQxNTlmMiJ9.-2jpcliMYWRk7klrrPUUTAJgDVOIZJaX7ar2afPG3Yk	cmuno5h2w0008c6uvkn4m9h60	CUSTOMER	2026-10-07 11:35:37.355	okhttp/4.12.0	7d596b709fda74cf	RMX3933	14	172.68.211.56	2026-09-30 11:35:37.356
cmuo144ov000dc6i79ynjs9g0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMG1mNGIwMDA2YzZpN2M5d25la2Q5Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MDc2ODE0MCwiZXhwIjoxNzkxMzcyOTQwLCJqdGkiOiI2NTU1ZWVkNy1kODEwLTQ0N2YtYmY5Zi1lZDAzMmU1MWRkNGUifQ.Ga2hugVf862kBNi7aPCi1A7a6xi0oqNjFuz7s4WqaLU	cmuo0mf4b0006c6i7c9wnekd9	VENDOR	2026-10-07 11:35:40.735	okhttp/4.12.0	7d596b709fda74cf	RMX3933	14	172.68.211.56	2026-09-30 11:35:40.735
cmuo1mi1v000kc6i77vof7fgv	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzY4OTk3LCJleHAiOjE3OTEzNzM3OTcsImp0aSI6ImRhMDczZjc0LWI2ZTAtNGYxYy1hMDRlLWZiYTA1OGIzMTViNyJ9.aDMShZ-CzVN4pHf-eJu3_VGZfhuGvb-s7k0GQIz0Kss	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 11:49:57.856	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.71.211.44	2026-09-30 11:49:57.86
cmuo1mspn000lc6i7ekmqmx3e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzY5MDExLCJleHAiOjE3OTEzNzM4MTEsImp0aSI6ImU2MjRiNmIxLWU5MzYtNDYwNS04MmExLTUwMjE0YjNiYjdkYiJ9.Po08FU21x-9XhJPIv4sagJoxPCLOz-c-NaHLKKF72us	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 11:50:11.674	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.69.176.9	2026-09-30 11:50:11.675
cmuo9yhib000oc6i76dfse69j	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzgyOTkzLCJleHAiOjE3OTEzODc3OTMsImp0aSI6IjQ3MDljOTMyLWYxNDEtNGI4ZC05Yzg1LWJjYWI2NTRkOTYwZSJ9.enMBzQXH3QtpsiZaaBZ_IOm0x6mqRvh4bXKRRZRK0_s	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 15:43:13.945	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	162.158.10.145	2026-09-30 15:43:13.954
cmuodepel000pc6i7b0p2yfk5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzg4Nzg5LCJleHAiOjE3OTEzOTM1ODksImp0aSI6IjRhZmIyYjVkLTFkNTgtNDEwMi1iY2ZjLTgyNDBjMTgyOGMxZiJ9.DERx3oTefc7IP15OK9-qlRrfqDMCq6NZ5QOcnbdXme4	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 17:19:49.532	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	104.22.14.112	2026-09-30 17:19:49.533
cmuoe5jom000qc6i7ar1aai3p	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwNzkwMDQxLCJleHAiOjE3OTEzOTQ4NDEsImp0aSI6ImJmZjU5OTk5LTg3ZjUtNDMxYy1iNWI3LTBlOWE5ZDgyYjRhNyJ9.RSIFR8wT46URxtIWqWsWRwGld5c3eXtU5qXdok_FNgk	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-07 17:40:41.83	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	104.22.14.112	2026-09-30 17:40:41.83
cmuou3xkp000rc6i7zvymocrl	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwODE2ODQwLCJleHAiOjE3OTE0MjE2NDAsImp0aSI6IjE5ZDlhYThhLTQwYmEtNGE5ZC1iZGJlLTVhZDA3YjA3ODVlNiJ9.LDiyGfO49-e50k3EP6Zf4HuXFabEK0QN0W2wRxzL_Bs	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-08 01:07:20.375	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	104.23.168.32	2026-10-01 01:07:20.377
cmup1cy07000sc6i7mfjekd5i	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwODI5MDE4LCJleHAiOjE3OTE0MzM4MTgsImp0aSI6ImMwYjU5MDIwLTI1NzgtNDMzYS05ZTI2LWE3YWRlMDkxYzcyNyJ9.21sndMXMnrRtirmKmOpDYwSAiHLwNQrHGCPEiwMOFAc	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-08 04:30:18.151	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	162.158.88.139	2026-10-01 04:30:18.152
cmup46zpz000xc6i7161s587k	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwODMzNzc5LCJleHAiOjE3OTE0Mzg1NzksImp0aSI6IjJhY2NjZDIwLWE0ZGQtNGQ4Yy1hNWFlLWM2MzA1NTYwMTM3MCJ9.6ml3FezVNcjt-h0K8Vfjj8DnbI2fxo_upFrrak1jmBQ	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-10-08 05:49:39.287	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-10-01 05:49:39.287
cmup48wt9000yc6i7m9guvgvy	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwODMzODY4LCJleHAiOjE3OTE0Mzg2NjgsImp0aSI6IjcxMTViNmIwLWNlNjMtNDUxYy05MTQ4LWM0YmE2ZmQ5NjFhYiJ9.pfCgWL3J6c6QerP57uYi9BC7fIG9PWysRPJ5-_Kqk74	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-08 05:51:08.828	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.71.95.101	2026-10-01 05:51:08.829
cmup4ghhm000zc6i7553w3fe2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwODM0MjIyLCJleHAiOjE3OTE0MzkwMjIsImp0aSI6Ijg0MDdhYmZkLTJjNTktNGMwZC1hNDcwLWQ0YjBkOTQ2NmVjMSJ9.wizIcoBjnN1H1OlsOPFn5AiiTciuxJaKoaHqhvUl3xI	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-08 05:57:02.217	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	162.158.114.94	2026-10-01 05:57:02.219
cmupba85y0014c6i76y5gio3y	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVwYmE4NWMwMDEyYzZpNzcxZGc2OTV6Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwODQ1Njg3LCJleHAiOjE3OTE0NTA0ODcsImp0aSI6ImMxNjQ3MDg2LTZhMGEtNGMwMS05NTkyLTlhZDFhNjZkYTZmZCJ9.Pvf934gif4sxY21_WTZuCoRxrKDtFnsYiUnLWp9oMUk	cmupba85c0012c6i771dg695z	CUSTOMER	2026-10-08 09:08:07.509	okhttp/4.12.0	52b726d0a2b1ac51	RMX3870	16	162.159.99.64	2026-10-01 09:08:07.51
cmupq91j8001zc6i7pg7sovly	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MDg3MDgyNiwiZXhwIjoxNzkxNDc1NjI2LCJqdGkiOiJkNzQ1MjhmOC01ODc0LTQ3M2EtODFkYi00ZmQ2N2YyNzhlZmUifQ._D-mWH3t4endUlm1Q223fV2yye_thtNHEBuBYUFhmlM	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-10-08 16:07:06.499	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	104.22.14.112	2026-10-01 16:07:06.5
cmupv3sfy0020c6i7unbphip0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwODc4OTc5LCJleHAiOjE3OTE0ODM3NzksImp0aSI6ImE0NWI1NmU2LThmOGYtNGFjMC1iNzI2LTVkM2Y3NWE0OTQ1YSJ9._EeOxeQpHYB3GhuJfl99iZZjby_ATwH0WRDc1Es6da0	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-08 18:22:59.517	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	172.71.124.32	2026-10-01 18:22:59.518
cmupw6ab30021c6i7tv47an6e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwODgwNzc1LCJleHAiOjE3OTE0ODU1NzUsImp0aSI6IjE3ZTE4YzU0LTM3ZmItNDhlZC1hMzMzLTlmYTU0MzNhNWJiMyJ9.ugPk3O9GIVSRBovWcxSYcTsypuWGjtnQWZ9L1ANZD4o	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-08 18:52:55.598	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	172.70.142.199	2026-10-01 18:52:55.599
cmuqjg4fq0001c6swrmnpidwr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTE5ODY1LCJleHAiOjE3OTE1MjQ2NjUsImp0aSI6ImExNmE2YmQzLWNhMWUtNGYxNi1hNTJjLWU1YjE4MGFkYzJiNCJ9.zd0kllRb866e7FH6UevdD3mrEzTren65AYcj4wVMVAY	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 05:44:25.718	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	104.23.175.182	2026-10-02 05:44:25.719
cmuqjljbi0002c6sw3q1dmvsg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTIwMTE4LCJleHAiOjE3OTE1MjQ5MTgsImp0aSI6IjYwZWVmM2M3LTBiOTgtNDZhMC1iZGQxLTcxZDcyNTBiY2RjYyJ9.LA4SNg7Hpz1JU3k4Aq1uq5cjZIHHiW0GIsc5jqboWG8	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 05:48:38.285	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	162.158.170.155	2026-10-02 05:48:38.286
cmuqjug160003c6sw1q2ywxvg	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTIwNTMzLCJleHAiOjE3OTE1MjUzMzMsImp0aSI6IjMyYjE4MWI2LTg5ZjEtNDQ5NS1iZDQyLWI5ZDNlMzUxNTM1MSJ9.loZAfgonBAFb7LWMsvtj2ePW-HCkDbHyoKxoe9MsBcw	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 05:55:33.929	Mozilla/5.0 (Linux; Android 15; V2303) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/16.5.2.0	\N	\N	\N	172.71.124.32	2026-10-02 05:55:33.93
cmuqjz5ec0007c6swl3lq1lcf	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MDkyMDc1MywiZXhwIjoxNzkxNTI1NTUzLCJqdGkiOiJiNmQzZTRmMC1hZTk4LTQzMmYtOTM3Ny01NWFhOGNjM2NlZTMifQ.-NJa5JOonKIlKbkH5jnWlGU4jpDcRSFWJ9pedUoZtys	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-10-09 05:59:13.427	okhttp/4.12.0	211a141fbd5b2945	V2511	16	172.70.142.199	2026-10-02 05:59:13.428
cmuqjz8h00008c6swpmo8cil4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwOTIwNzU3LCJleHAiOjE3OTE1MjU1NTcsImp0aSI6IjFjMjdjZjkxLTA5YmYtNDgyMi04MTgxLTQ1YzRmOTFhYTdjYSJ9.-0NQcdJ71Y47W77ve5n4azhfmKlzpvu8DBfjzm1vH7Y	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-10-09 05:59:17.411	okhttp/4.12.0	211a141fbd5b2945	V2511	16	172.70.142.199	2026-10-02 05:59:17.412
cmuqjzcus0009c6swblain4fu	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTd5Z3EwMDBkYzZxbjRxbjQwbWd1Iiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MDkyMDc2MywiZXhwIjoxNzkxNTI1NTYzLCJqdGkiOiIyOTRiZjExMy05NzQ5LTQ4OTctYjZiOC1jMjc1YjE2N2Q2ZDUifQ.h6t7ShKs7zl_iKtpG2e4PQipfuZcnFStbNoYt7cprfY	cmto17ygq000dc6qn4qn40mgu	VENDOR	2026-10-09 05:59:23.092	okhttp/4.12.0	211a141fbd5b2945	V2511	16	172.70.142.199	2026-10-02 05:59:23.093
cmuqjzg3n000ac6sw0mokcdu8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRtbWs0NzMwMDF5YzZkazNoYzhtY3YyIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwOTIwNzY3LCJleHAiOjE3OTE1MjU1NjcsImp0aSI6IjgzZDRkYmQyLTQxMDAtNDE4Yy05ZjJmLWQ1YjJhNjc3MTViMiJ9.QfxACK74Q5gAgV9ffAmSEYsqyAsViQMHHUs7SRnE-BA	cmtmmk473001yc6dk3hc8mcv2	CUSTOMER	2026-10-09 05:59:27.299	okhttp/4.12.0	211a141fbd5b2945	V2511	16	172.70.142.199	2026-10-02 05:59:27.3
cmuqo1ena0012c6sw0uq9d075	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTI3NTc3LCJleHAiOjE3OTE1MzIzNzcsImp0aSI6ImQzNjRmMzBiLTY1NDctNGJiNC1hNzQ4LWMzMjk1NzA0YmQ2NyJ9.PfiaTTpg1Li_uV4cpUJoYScEVUDkPmakwcEj42Y3zZY	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 07:52:57.189	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	172.70.93.16	2026-10-02 07:52:57.191
cmuqoltuu0013c6swgeq5lhb9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTI4NTMwLCJleHAiOjE3OTE1MzMzMzAsImp0aSI6IjA4NjhmNGU3LWIyYTItNDdkMC1hMzEyLTQ3NjFlZjE0NjRhMCJ9.Ec3XLft1kNmi4p-8E0RKloYbQ-UrAB-vJ46Rs24hxug	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 08:08:50.021	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	162.158.162.74	2026-10-02 08:08:50.022
cmuqoq0kl0014c6sw8d05fkbw	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTI4NzI1LCJleHAiOjE3OTE1MzM1MjUsImp0aSI6ImI1MzdlYjkwLWU5ZTYtNDJjNC04OGY0LTIwOTU0MzMwZjQ4MCJ9.wD3j7l-JC2GgYShf_1rNjbLlfJKizVrgtD9v9SXbzUo	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 08:12:05.349	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	172.70.93.16	2026-10-02 08:12:05.35
cmuqpwvbs0000c6dq5ii357gf	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTMwNzI0LCJleHAiOjE3OTE1MzU1MjQsImp0aSI6ImQ3MDNjZmIyLWYyNGYtNDZlZi1hZGY5LTY4ZmRkNTgyZGE0MiJ9.msiEUy7nIRDp-IqQGN2SiZfxLV0g0RcB8MB21hf2TjA	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 08:45:24.76	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	172.70.208.141	2026-10-02 08:45:24.761
cmuqqwxx70003c6dqa9ixzgsj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTMyNDA3LCJleHAiOjE3OTE1MzcyMDcsImp0aSI6IjEzMjhjMjM0LTMwZDctNGNhZS04OGJjLWRiMTI3MTI5ZTUxYiJ9.v6-_m9x7pBCtrOl6Or9-FirfLkkroD-Q99ThDY3UXWk	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 09:13:27.738	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	172.70.93.17	2026-10-02 09:13:27.739
cmuqrgtqp0008c69bjxaakn6y	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTMzMzM1LCJleHAiOjE3OTE1MzgxMzUsImp0aSI6ImUyMzMwYjZjLWUwODktNDE1OC1hMzY0LWE1MzdjOTcwNzA4YSJ9.ZFqOnmB71QKc47doddIi3GVRx4IQk2OB9M5dWdOGJys	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 09:28:55.441	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	162.159.98.133	2026-10-02 09:28:55.442
cmuqt7zkr000yc69bpg0ie65n	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTM2MjgyLCJleHAiOjE3OTE1NDEwODIsImp0aSI6ImJlZTdmYzEwLWQwOWYtNDczYS05MWQ3LTQ5MDYwNWI1N2ZmNSJ9.2idaKNnWLWq2dvTjLghvp4uQ3c93hLsYQ8wjPrrh1hA	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 10:18:02.331	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	172.69.176.58	2026-10-02 10:18:02.332
cmuqtazgc0015c69bvyx3mzdd	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTM2NDIyLCJleHAiOjE3OTE1NDEyMjIsImp0aSI6ImE3NTM0MDZjLWNhOTAtNDZiZC04YTQ5LTgzZmE2ZTNlOWNhZCJ9.ARvJos4obLGfZj3jJaxDEDBHuBHBeo075iS7B7WRpJI	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 10:20:22.14	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	162.158.170.155	2026-10-02 10:20:22.14
cmuqtb1wz0016c69bh60ii0qj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTM2NDI1LCJleHAiOjE3OTE1NDEyMjUsImp0aSI6ImFkODViYzc0LTQ4YzEtNGRiMS05M2QzLTkzNjFlMzAxMWM2MSJ9.N29_umE2LIl4JF-AIWjrW1SYirZhbGPE3s8BGv0sy6w	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 10:20:25.33	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	104.23.175.182	2026-10-02 10:20:25.331
cmuqtkspd001hc69b9lyp8rmd	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTM2ODc5LCJleHAiOjE3OTE1NDE2NzksImp0aSI6IjJlMzU0NTllLTQ5MjMtNGRkYi04YjA5LTVhMWE2OTdkMTc3ZCJ9.fZ-soByPUQzsmZ5xpyuAfyR-C7Lc4kMDpAEGm0L9HII	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 10:27:59.952	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.70.208.141	2026-10-02 10:27:59.953
cmuqtocj0001rc69bvy1xxnmm	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVxdG9jaW8wMDFwYzY5YndoYmpycTkwIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkwOTM3MDQ1LCJleHAiOjE3OTE1NDE4NDUsImp0aSI6ImUwMzZkNDU4LWE3ZjAtNGUyZi1iYzgyLWUxZjk4MzBkODhmNSJ9.DxJz4K9emdv67_EPmkgAxqSiPyQPJg0T9LFOpxMP26k	cmuqtocio001pc69bwhbjrq90	CUSTOMER	2026-10-09 10:30:45.611	okhttp/4.12.0	ba2ad42934b433f9	V2513	16	172.70.188.107	2026-10-02 10:30:45.612
cmuqvz0ii002ac69bv9gwmh6c	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTQwOTAyLCJleHAiOjE3OTE1NDU3MDIsImp0aSI6ImMzNWY3NTVlLTZiODktNDkwNi1iZDEyLWZiNzYwNGI4NzhiYSJ9.N-C-du1s7KMG-TUqkFeC8I5MS3br6_FBmyackV8REXI	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 11:35:02.489	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.70.142.198	2026-10-02 11:35:02.49
cmuqxexby002cc69b4vnddl5d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkwOTQzMzI0LCJleHAiOjE3OTE1NDgxMjQsImp0aSI6IjMxMjEzMTQ0LTY1OWYtNDQyNy05YmIwLTA5N2IwMTg4MDI2OSJ9._vL1J9vwpoQtgOG_YivafuSkZtIwAI16O7_B9bXJV_0	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-09 12:15:24.477	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	162.158.88.20	2026-10-02 12:15:24.478
cmurwioli002fc69bzap4a5en	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMDAyMjg2LCJleHAiOjE3OTE2MDcwODYsImp0aSI6ImZkYzIwMjkzLThmNDYtNDg3Ni04YmZjLTNkYmUwZjVjOThiMCJ9.3Pf3UjSxaiDsIR0Wlcdh5eicNyV0i--m2zUfbzWplGo	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-10 04:38:06.341	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.70.208.97	2026-10-03 04:38:06.343
cmus31tf30035c69b649j68t6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVzMzF0ZXIwMDMzYzY5YnBidXhvcW5rIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMDEzMjU2LCJleHAiOjE3OTE2MTgwNTYsImp0aSI6ImJkNDY1ODA2LTA4MzAtNDgwNi1hMWM5LTkxZDM2MmMwYWUwYiJ9.WNWGDvM4A3QJHN_1Rr6WLNvYLGoCwdleDwAo1vSKX8Q	cmus31ter0033c69bpbuxoqnk	CUSTOMER	2026-10-10 07:40:56.75	okhttp/4.12.0	a93a20c12e9d862c	motorola edge 60 fusion	16	104.23.175.183	2026-10-03 07:40:56.751
cmus7nzse0039c69b088g48ua	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVzN256cmwwMDM3YzY5YnM3OWRzNWZjIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMDIxMDA5LCJleHAiOjE3OTE2MjU4MDksImp0aSI6IjFkZjI0NjY0LWJkZjYtNDc2Ny05ZmIyLTMwYzdhZjIyYTU2NyJ9.eR0QXjJfWu3BeQjfI1ghd_Et_a0qQRA6ZJQvSMoYIMI	cmus7nzrl0037c69bs79ds5fc	CUSTOMER	2026-10-10 09:50:09.901	okhttp/4.12.0	880ecf3036d9a59c	SM-A366E	16	172.71.124.32	2026-10-03 09:50:09.903
cmuscsknd003dc69bwahmjqw2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVzY3NrbXEwMDNiYzY5Yjl1eTJnOXUzIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMDI5NjIxLCJleHAiOjE3OTE2MzQ0MjEsImp0aSI6IjRiMDA5OWY1LTI0NmYtNDBjNy05NTc0LTQzNGQ3Y2VlZmQ3ZSJ9.uGEZAaLsDdttKyeWrptXm1pQ1iRoHY8Tjwx1oHsGI4o	cmuscskmq003bc69b9uy2g9u3	CUSTOMER	2026-10-10 12:13:41.637	okhttp/4.12.0	d7ad099bd27be53c	SM-A146B	15	172.68.146.197	2026-10-03 12:13:41.642
cmuteq86u0000c61plaipjaj2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMDkzMzM3LCJleHAiOjE3OTE2OTgxMzcsImp0aSI6ImY2ZGE1NDAwLWRmZjEtNGI3NC1iZmIxLTBiNDI0OTEwZjU1OSJ9.KciI8ke-UhkOjz2s2c5C66tR6WgimXmFt1qpYE_PPS4	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-11 05:55:37.588	Mozilla/5.0 (Linux; Android 15; V2303) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/16.5.2.0	\N	\N	\N	162.158.108.15	2026-10-04 05:55:37.59
cmuus2qko000ec61p9aowmzb5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMTc2MjIyLCJleHAiOjE3OTE3ODEwMjIsImp0aSI6ImUyYjc0YmI0LWI0ZjAtNDA0Yy1iMGM5LTNhYmZiMzMzYjk0OSJ9.rzfUQsq21kl27WyjmxAw9aHDzvwRusXj7YBuT7bjpqo	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-12 04:57:02.471	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.70.208.140	2026-10-05 04:57:02.473
cmuuu2gy0000jc61pcbb45acp	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1dTJneGUwMDBoYzYxcGtyYmloZnpjIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMTc5NTY5LCJleHAiOjE3OTE3ODQzNjksImp0aSI6ImI3MWQ1Mzg4LTQ1OTctNDQ3Yy1hNmFjLTM2ZTM1ZGMzOTNiNSJ9.4GJHH5pEl1AJ_42UyJedtBR789SOh8wSOynRGIh9QGI	cmuuu2gxe000hc61pkrbihfzc	CUSTOMER	2026-10-12 05:52:49.223	okhttp/4.12.0	35c87c75789ec3e8	V2513	15	172.70.142.198	2026-10-05 05:52:49.224
cmuuwhdw1000mc61pdpspgtvs	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMTgzNjI0LCJleHAiOjE3OTE3ODg0MjQsImp0aSI6ImYzOWYwYzUxLTdhYzMtNDkzMS1hYTVmLTJmNjU2YzY2OWFiNCJ9.hfVvTE3-Hhp8c7hBw2-JSK7J_hdbZht6iZgnkQ_9wWM	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-12 07:00:24.336	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	162.158.88.42	2026-10-05 07:00:24.337
cmuuwhq7z000nc61pmrd2t8z2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMTgzNjQwLCJleHAiOjE3OTE3ODg0NDAsImp0aSI6ImE5ZTk5ZTU0LWU4ZDItNDYzZi05MWYzLThmZmRhZjI3MDVjNyJ9.xaDNIvhBOdB_1reWd97WwETF8pCgELiXptoaNXc3K1A	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-12 07:00:40.318	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	162.158.88.42	2026-10-05 07:00:40.319
cmuuwlqe0000rc61p6e4kfcew	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMTgzODI3LCJleHAiOjE3OTE3ODg2MjcsImp0aSI6ImM5MzljOGE0LTY1ZjktNDY2YS1iMjViLTFjMWFlMzlmM2NlMSJ9.IBWN3_T6-7vjUbVzBCqO9fjvS0eX0w9y-Y-1fgb6yXk	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-12 07:03:47.16	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	104.23.175.183	2026-10-05 07:03:47.161
cmuuwy6cx000yc61p1gatomwz	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTE4NDQwNywiZXhwIjoxNzkxNzg5MjA3LCJqdGkiOiJjYTJjZWY3MS03ZjgyLTQ3YTAtOWVhNC0xYTNlZDA0OWVkMDYifQ.PS1yBd8IUzERackhNZrRM48kfwK7BVdj11jTISVqEAk	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 07:13:27.729	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.69.165.24	2026-10-05 07:13:27.73
cmuux19pb000zc61pgoio7ea9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMTg0NTUyLCJleHAiOjE3OTE3ODkzNTIsImp0aSI6IjE0MWEyZGE2LWEyYzQtNDVhYi1iNmU1LTU1NjQ3Nzg5NWMzYyJ9.pq5VMe1HEafHeY7JyOt2b4pgYdIwecrBdN3NEvxoP2g	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-12 07:15:52.027	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	162.158.88.43	2026-10-05 07:15:52.031
cmuux9dyu0010c61pezx78eop	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTE4NDkzMCwiZXhwIjoxNzkxNzg5NzMwLCJqdGkiOiI1NGI2NTViNi0wODI3LTQzNGQtOTA4MC1mNjQ1MjAwZDEwNWEifQ.rkvEPDetwVaEwgUO_DrgBfONMjFU0AZ1BsraG1PMTy8	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 07:22:10.806	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.71.81.18	2026-10-05 07:22:10.807
cmuuxb3z50011c61peq97md3z	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMTg1MDExLCJleHAiOjE3OTE3ODk4MTEsImp0aSI6IjAxODU2MWJmLTM0NjUtNGM1NS05ZDI2LWY1NGFjOWYxNWNmYSJ9.KtuotaA0mqE6-9Me3_MhWXvMLhffX0Su0vDMSbI4ZIE	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-12 07:23:31.168	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.69.165.25	2026-10-05 07:23:31.169
cmuuxbp9v0012c61ph77vonvi	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTE4NTAzOCwiZXhwIjoxNzkxNzg5ODM4LCJqdGkiOiIzZmQ2NDgyZC1lMWQwLTRiYTktOGUyMy0yMmI4NmExOTE5MjQifQ.7NcSvGqXPrFI-mmIquEOkCtU-MjlTUjABXQg5W-Mm3w	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 07:23:58.771	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.69.165.25	2026-10-05 07:23:58.772
cmuuxbxvg0013c61pkh6oxlx9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMTg1MDQ5LCJleHAiOjE3OTE3ODk4NDksImp0aSI6IjQ5M2Q5OTdhLTEzZWEtNGVmMi05Y2VlLThjZWI3NDBmNTYxOSJ9.lZyCKeR8yJBiLmljuIz1_idp9mvjdnBXmXJkR902X74	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-12 07:24:09.915	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.69.165.25	2026-10-05 07:24:09.916
cmuuxcwwb0014c61p59903wy1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTE4NTA5NSwiZXhwIjoxNzkxNzg5ODk1LCJqdGkiOiJjOWE1ZmViOS0xNjQyLTQ5MDYtODhhNC00ODdmMGUyZmU1ZDQifQ.DD8hVdzBd5ddiSi7DLJXaX5KyEWYnwrnWa54FxSkGyY	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 07:24:55.307	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.69.165.25	2026-10-05 07:24:55.308
cmuuyy4yg0015c61pjwt9187r	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMTg3NzY1LCJleHAiOjE3OTE3OTI1NjUsImp0aSI6ImNiNGZhMzE3LTlhMGEtNDEyOC1iNjAxLTAyZjBmYzRlMzQ2YyJ9.2_PSUDhSQxS5PDpQnkYjUmh0ZBLX4doOBErqejVGxww	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-12 08:09:25.143	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.71.124.16	2026-10-05 08:09:25.144
cmuuzd5870016c61privfbnel	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTE4ODQ2NSwiZXhwIjoxNzkxNzkzMjY1LCJqdGkiOiJhMTE0ZmRkNi02NTAzLTQ0ZmMtYTJlNy1mOTJhYzRiYTQwYWQifQ.Dy38YywFfK6TFgYhqKglZzEjX1tUo0sTcpyUxNpS-0o	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 08:21:05.335	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	104.23.175.183	2026-10-05 08:21:05.335
cmuuzeet20017c61pvfi15mmw	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMTg4NTI0LCJleHAiOjE3OTE3OTMzMjQsImp0aSI6IjFlZTk4NTg2LTJlMTMtNGFkMy1hZjg2LTg0OTQzMWUxMmNiMiJ9.7qN1bEM9KBF0JID_ozCgXlXTCr4xg61QOBuH-FYButg	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-12 08:22:04.405	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	104.23.175.183	2026-10-05 08:22:04.406
cmuuzvrbl001kc61p33e4ns3g	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTE4OTMzMywiZXhwIjoxNzkxNzk0MTMzLCJqdGkiOiJlYjAwOTdiOS02YmYyLTQ1YTQtOTViMC01OWMyYzM1YjIyNzQifQ.5M2CIo7VYmdjwfRL7C1zMPUnzL1FbX4RiceOwnRiBmI	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 08:35:33.777	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.70.93.17	2026-10-05 08:35:33.778
cmuv2tiix001lc61psskk1sg4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMTk0MjY3LCJleHAiOjE3OTE3OTkwNjcsImp0aSI6ImI2OWY5MTUxLWZlNDEtNDU4NC1iNDYwLTc5MGJiZmNjYTExYyJ9.49me7fPJo_PevEFA-f719uHfJSrdfdkClI7QaZn9nS0	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-12 09:57:47.912	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	108.162.226.18	2026-10-05 09:57:47.913
cmuv663wk001mc61pov23ofji	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTE5OTg5NCwiZXhwIjoxNzkxODA0Njk0LCJqdGkiOiIzZjU3MTllNS0zZGJiLTQ0MTItODZjMy1kYzVkNDcxZGQ5NjUifQ.ojWh0Me5jhBMw7A7Wri-IEo1G2dgei4KtAWRbX60oEc	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 11:31:34.339	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	162.158.88.43	2026-10-05 11:31:34.34
cmuv6fg0p001nc61ps9mqdqcw	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjAwMzI5LCJleHAiOjE3OTE4MDUxMjksImp0aSI6ImI4YjRlOGIzLWNmYzUtNDRhMC04MTU3LTFiMjcxN2NmYWY4MiJ9.W97GXvRjVydSK2usNeatL9fcAIA7Mgkqikir3OvxDBU	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-12 11:38:49.945	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.70.142.199	2026-10-05 11:38:49.946
cmuv6h7zf001tc61p09g75pj8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV2Nmg3ejQwMDFyYzYxcDEyYjQ3Yzh4Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjAwNDEyLCJleHAiOjE3OTE4MDUyMTIsImp0aSI6ImVjNGNmMzQ2LWJkOGQtNDRjYi05YjhiLTBhMTU4ZjcyYWE1MSJ9.G6yxPauzUW8L1Pb58XCanO21-ZXC4wZKVYOdhqF5Zm0	cmuv6h7z4001rc61p12b47c8x	CUSTOMER	2026-10-12 11:40:12.843	okhttp/4.12.0	d4273f4d700c01d7	V2251	15	172.71.81.17	2026-10-05 11:40:12.844
cmuv6htq90020c61p3afojyls	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTIwMDQ0MSwiZXhwIjoxNzkxODA1MjQxLCJqdGkiOiIzNjFmZWM5Zi04NjEzLTRmZWYtOGQ0My0wZDU2NWRiNDY4OWUifQ.lgnavAGxuk0RaxrGdul8ABTOkezBajSOSogCYrbw7HU	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 11:40:41.023	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.69.165.25	2026-10-05 11:40:41.025
cmuv71o9f002ec61pt2q2vm98	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjAxMzY3LCJleHAiOjE3OTE4MDYxNjcsImp0aSI6ImYyYzIxMGI4LTM1NGMtNDFlOC1iMmIzLTUxMzZlMmI1ZjYxNiJ9.PC4cf-CWKPmujCuh9ZeZWT-alNt6Rz8I1vnmOK2iPyc	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-12 11:56:07.059	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.70.142.198	2026-10-05 11:56:07.06
cmuv72a5u002fc61pbrpj3akz	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTIwMTM5NSwiZXhwIjoxNzkxODA2MTk1LCJqdGkiOiI4NWE4NTI1MS0xNDdiLTQ4M2EtYmRiMi02NjAwZDQyZmFhM2MifQ.duRJuXxoaVgzvBqy0rs86bJhpCpRqj4hq4_xKzYZhYI	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 11:56:35.442	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	104.23.175.183	2026-10-05 11:56:35.443
cmuv73b0y002gc61pz62ccblr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjAxNDQzLCJleHAiOjE3OTE4MDYyNDMsImp0aSI6IjJjZjY3YzNhLWNkNjktNGYyMC1hMTllLWQzYjE3MTM2MTgyNCJ9.yB0evshjlNjwhcJD_a6jrXyuXkACf3tJPD0x4urc-jE	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-12 11:57:23.217	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	104.23.175.183	2026-10-05 11:57:23.218
cmuv7awt9002hc61pt3mnv09b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTIwMTc5OCwiZXhwIjoxNzkxODA2NTk4LCJqdGkiOiJiM2E5ZTY1Yy1jNmI1LTQ4M2QtOTE5YS1iMjVlN2NiYWQwYWEifQ.5gJHnAFkDlwKpq2lgvrw-1bTQCGolBERdVC1uDOrOYM	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 12:03:18.044	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.68.164.135	2026-10-05 12:03:18.045
cmuv7azai002ic61ph1ct5xxb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjAxODAxLCJleHAiOjE3OTE4MDY2MDEsImp0aSI6IjIzZGIyMGQ0LTQ1YTYtNDhiNS1iNDVlLTE5YjZkYzVkZWM1OCJ9.GTt6QXgNSiPJftrBKbiHQsug8-y38wy6M5HnGTVq3sc	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-12 12:03:21.258	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.68.164.135	2026-10-05 12:03:21.259
cmuv7dekv002jc61pbtpnyytc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTIwMTkxNCwiZXhwIjoxNzkxODA2NzE0LCJqdGkiOiIyOTcxNjk5NS04NmMzLTQ1YzItOTVmZi0xYmQxYTFlNThhZWMifQ.orC2b3As64GA1GLS0BL0tWFkWtOGMp7k_Tu5wUZc_TE	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 12:05:14.382	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	104.23.175.183	2026-10-05 12:05:14.383
cmuv7elb5002kc61pvxl1ry1z	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjAxOTY5LCJleHAiOjE3OTE4MDY3NjksImp0aSI6ImM0MWQxYTdlLWY3Y2EtNDA4ZS04YjEzLWJjZWU5ZDBjYWVmMCJ9.XZg51jSbGdFnxqf6txqj_EvGsno1uJ5lZHUx7CiZHn4	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-12 12:06:09.761	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	104.23.175.183	2026-10-05 12:06:09.761
cmuv7eoks002lc61peal3axq8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTIwMTk3MywiZXhwIjoxNzkxODA2NzczLCJqdGkiOiI1ZjVlN2M2Mi1jOGQzLTQwMDgtOTQzMC0yOTJhZGQ4MjUzMmIifQ.S_DSJ-GnRqxMIwX8nDM9qImf7pb2w-U5qJzCmPkGTsc	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 12:06:13.995	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	104.23.175.183	2026-10-05 12:06:13.996
cmuv7f8y5002mc61paa7mvusz	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjAyMDAwLCJleHAiOjE3OTE4MDY4MDAsImp0aSI6ImI0OGQxODk0LWRhNDktNDViNy05ZThmLTNmYWQ3ODkyNzg0ZiJ9.mOxKi_Gaz02jE_c95tDCAFrOxxUvxf91B7mYe_yF71A	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-12 12:06:40.396	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	104.23.175.183	2026-10-05 12:06:40.397
cmuv7fj5z002nc61pmjaphomz	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMjAyMDEzLCJleHAiOjE3OTE4MDY4MTMsImp0aSI6IjZmNDFmNWRlLTJiYjItNDVjYS04MzVmLWQwMDkzNzRkOTQxYiJ9.Xg5azJwAEpC0GVbSwN1RLA30KW3Ezyw0LVgF5G6Gzlo	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-12 12:06:53.638	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	172.69.176.58	2026-10-05 12:06:53.639
cmuv7lft9002pc61p9tabcqot	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTIwMjI4OSwiZXhwIjoxNzkxODA3MDg5LCJqdGkiOiIzZjY5ZTEyMS0yZWE0LTQzODMtOWRmNi03YTYxMDUyYTE4NzQifQ.IAssnXo2U4S8wAtopZ7yQnZMdXeG8lh1V3UfjvyIrTs	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 12:11:29.228	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.71.81.18	2026-10-05 12:11:29.229
cmuv7lhd9002qc61ptnlp8htp	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjAyMjkxLCJleHAiOjE3OTE4MDcwOTEsImp0aSI6ImNiNGEzZjM2LTEzODMtNDAwMy1hZGJhLWMxYWIwNjYzZDk0ZCJ9.0AmZBk_Q-8V-MfYWBOfP7prleeYKeA_a_1iN7smaZhM	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-12 12:11:31.244	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.71.81.18	2026-10-05 12:11:31.245
cmuv886t40030c61plze4utli	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV2ODg2c3kwMDJ5YzYxcGgzd2FqY2VrIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjAzMzUwLCJleHAiOjE3OTE4MDgxNTAsImp0aSI6IjU5ZjVkNmUxLTA2MmMtNDAxOS1hNjYwLTY3OGIxNmZhOTYzYSJ9.pAst5a6qQ-I8SYNXZIwk1gdwpI5JKy06LS2ZyEIsn98	cmuv886sy002yc61ph3wajcek	CUSTOMER	2026-10-12 12:29:10.648	okhttp/4.12.0	bd8ff23250f3926a	V2334	15	162.158.108.15	2026-10-05 12:29:10.649
cmuv8npqh0036c61pazg35f37	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV2OG5wcHowMDM0YzYxcDR4ZXh5MnZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjA0MDc1LCJleHAiOjE3OTE4MDg4NzUsImp0aSI6ImE2OGE2M2FhLWU1MzgtNGVkOS1iOTc1LTdiMWUxYTVjNjg3NCJ9.7VzEdfVlWXQWPYK3-vJfUCOxshboIXSH6mZHlU-q3AY	cmuv8nppz0034c61p4xexy2vq	CUSTOMER	2026-10-12 12:41:15.016	okhttp/4.12.0	768bf8d8e23bcf17	V2416	14	162.158.108.14	2026-10-05 12:41:15.017
cmuv9l3hd0037c61pgiuvr1h3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTIwNTYzMiwiZXhwIjoxNzkxODEwNDMyLCJqdGkiOiI1MGY4NjY0NS0zM2ZiLTQ2YzEtYjU4YS0wODg0MDNmZDI5YWMifQ.TFMTu3_sN49qkWU1ndwxvSnIN3E17IY-dXnBlfqXmFU	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-12 13:07:12.481	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.68.234.134	2026-10-05 13:07:12.482
cmuve3lwg0038c61pl9r0aafv	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMjEzMjE0LCJleHAiOjE3OTE4MTgwMTQsImp0aSI6IjdhZWI4NDkyLThhYmUtNDcwNi1hODgxLWE2NjI0MTMxMjY4MCJ9.49ir1wmvrnOqvE9S4HwSXbXTf35aW8sycz_ykTq_kSE	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-12 15:13:34.623	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	172.68.242.37	2026-10-05 15:13:34.624
cmuvez7mf003cc61pozyg4ruc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXU2cW5nbXMwMDNnYzY0NHF1Y21zemNzIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjE0Njg5LCJleHAiOjE3OTE4MTk0ODksImp0aSI6IjE4Y2QzNzMwLWEzNmItNGUzMy04YTcwLTkxMjc4ZWU3OWZiOSJ9.j5lzfR7Re8TE8yhS7kpZTqioSRHjx4DFJq8IduAzdWg	cmu6qngms003gc644qucmszcs	CUSTOMER	2026-10-12 15:38:09.111	okhttp/4.12.0	293a954f65d6b29e	V2403	14	172.70.142.199	2026-10-05 15:38:09.112
cmuvgbh5a004jc61pl8ux9cm8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV2OG5wcHowMDM0YzYxcDR4ZXh5MnZxIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjE2OTQwLCJleHAiOjE3OTE4MjE3NDAsImp0aSI6IjU4ZWQwZWRkLTdkYmYtNDY4MS1iY2M5LWMwODE2NzBmNDRlNyJ9.8aOg9EoL_TrZaoqX0sviHqQ3p_gKx-lZNa4fy4JxxgY	cmuv8nppz0034c61p4xexy2vq	CUSTOMER	2026-10-12 16:15:40.942	okhttp/4.12.0	768bf8d8e23bcf17	V2416	14	162.158.88.43	2026-10-05 16:15:40.942
cmuw0yvue0002c6l3iwz4z38g	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMjUxNjI1LCJleHAiOjE3OTE4NTY0MjUsImp0aSI6IjIyYzg3MWJjLTcyZTYtNDgwMy1iNmFmLTJmMDA0ZWIxNDFkMyJ9.82Np6Etg0K_UPBIVbHPLIBP5wur4MeL_pM7470xKjss	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-13 01:53:45.394	Mozilla/5.0 (Linux; Android 15; V2303) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/16.5.2.0	\N	\N	\N	172.70.142.48	2026-10-06 01:53:45.398
cmuw7sr480003c6l38itj05sj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMjYzMDk2LCJleHAiOjE3OTE4Njc4OTYsImp0aSI6IjllMDExMDU0LTMwOTktNGI3OC1hMWMwLWVmZmQ3OWZkOGViYSJ9.6ArkcQ4DbajmvzON5zqQg9jL9eFWgbtiJbc_Q1-UOeM	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-13 05:04:56.647	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.70.142.198	2026-10-06 05:04:56.648
cmuwa91780004c6l39upzzuzr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMjY3MjE1LCJleHAiOjE3OTE4NzIwMTUsImp0aSI6IjYzMzgwZmY0LTlkNTgtNDUwNy04Y2I5LTJhMTM5NTI2YzRkOCJ9.QdhZa5F_Jf_ajrJxpjAt-N6IrF6icchVEgllCm6NdQ8	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-13 06:13:35.444	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.71.81.18	2026-10-06 06:13:35.445
cmuwk8bfx0005c6l3makvzy5e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXV1d3kzczQwMDB2YzYxcDllYjFweTFhIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTI4Mzk3OCwiZXhwIjoxNzkxODg4Nzc4LCJqdGkiOiJlMDkyNzIwZC01YjNmLTQxZGUtODk1MS02MjAwYjc2ZTYyNzUifQ.eBWgUEItmz06c2as2P5Bfe-qLydvcAvv-XwAR5VopxM	cmuuwy3s4000vc61p9eb1py1a	VENDOR	2026-10-13 10:52:58.22	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.71.124.17	2026-10-06 10:52:58.221
cmuwk8fp00006c6l3ooebvjto	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXVvMHY4YXkwMDA5YzZpN3lydjB0dHJhIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMjgzOTgzLCJleHAiOjE3OTE4ODg3ODMsImp0aSI6IjE5OGQxMzlmLTU3ZTYtNGUxZS1hMDlmLWU3MWI2N2QwYWE2NiJ9.KdS3DOm8azU6xtAQ0Rfr0gem4zvLGevIbw__908ezb0	cmuo0v8ay0009c6i7yrv0ttra	CUSTOMER	2026-10-13 10:53:03.731	okhttp/4.12.0	7ba098abcf5fa919	V2239	15	172.71.124.32	2026-10-06 10:53:03.732
cmuwkfd8l0007c6l3al61n8wf	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMjg0MzA3LCJleHAiOjE3OTE4ODkxMDcsImp0aSI6ImY5NDJhZTk5LTc5ODUtNGFjZS1hYWQzLTNmMjBhNmQyMmJkNSJ9.5O2j8TQ4zmCWyFXcx1mJdi5u6ZsEllavx1a7hQdIJ94	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-13 10:58:27.141	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.70.208.96	2026-10-06 10:58:27.142
cmuwkiw120008c6l3012rxbqz	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMjg0NDcxLCJleHAiOjE3OTE4ODkyNzEsImp0aSI6ImVhNWYwYmUwLWU0OTQtNGU5Yi1iNTE5LWU5MTRmNDlhNGZlZiJ9.Arro3L6b1Ge7F31zxpJiPMUmGHqB2WpMZyR4s6dn3l8	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-13 11:01:11.462	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.70.208.140	2026-10-06 11:01:11.463
cmuwmcp8a0009c6l3vwag4pkp	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMjg3NTQxLCJleHAiOjE3OTE4OTIzNDEsImp0aSI6IjdhNjYxZDRmLWY1MzEtNGVlZS1hNWI5LTNjMGEyZTA4YmNlZSJ9.djUsywMH4UgI0UVVBuE4ZmAws0v_rqza90sTlm4efuk	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-13 11:52:21.946	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	162.158.163.120	2026-10-06 11:52:21.947
cmuwouxkf000ec6l34jknoy0l	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMjkxNzUxLCJleHAiOjE3OTE4OTY1NTEsImp0aSI6IjhkYWY5ZTY1LTEwYTYtNDk3ZS05Y2ViLWZiY2FkOTlmYjgzYiJ9.GryVLgQ9xf7casGDzEEe0wEYl_zyYvw2wzd1PK4FN5Q	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-13 13:02:31.79	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	\N	\N	172.68.147.233	2026-10-06 13:02:31.791
cmuxfd4rk000fc6l3a6q1vpmc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTMzNjI3MCwiZXhwIjoxNzkxOTQxMDcwLCJqdGkiOiI5MmM4YWRhZC0yOWFlLTQxZDQtYjQ0ZS05ZGJmNjI4OGMyN2QifQ.3nAK2viUTmjMr0BJ1tfDN_xeN3cgYA491rlJp2UC7pE	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-10-14 01:24:30.943	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.158.108.94	2026-10-07 01:24:30.944
cmuxfe62j000gc6l3b91ynyu7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxMzM2MzE5LCJleHAiOjE3OTE5NDExMTksImp0aSI6IjM0N2U0ZjA3LTJhOGUtNGI1NC04OTBlLTk3YzIwZDdjYzU1MiJ9.hjVLuTzgaR6SP40q0eIv5lM-1dNOt_3WjPGVsrhbRcU	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-10-14 01:25:19.291	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.158.108.15	2026-10-07 01:25:19.292
cmuy908pl000hc6l3gwrsf843	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRscjE5dmMwMDAwYzY5NW44ZHVscWZuIiwicm9sZSI6IlNVUEVSX0FETUlOIiwiaWF0IjoxNzkxMzg2MDU4LCJleHAiOjE3OTE5OTA4NTgsImp0aSI6IjE1MzAwYmFjLTg1MmYtNDk0ZC1hYmMwLTllNmU5Zjg1NzcwMiJ9.H5RTHyEFLzs0inSJg5555s6wnE2sZADxgsZNzsos7U8	cmtlr19vc0000c695n8dulqfn	SUPER_ADMIN	2026-10-14 15:14:18.007	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	172.71.124.32	2026-10-07 15:14:18.009
cmuzmp15l000jc6l3pp95azpp	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvYjg5Mm0wMDN4YzZxbnFobXhwOGx1Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxNDY5NTE1LCJleHAiOjE3OTIwNzQzMTUsImp0aSI6ImRlZmEwY2NmLTAyNTgtNDRhNC1iMzZlLTY0OTBmYTkzNjBmNSJ9.hB2u_baH27x0Ks2lIDF2WryKt3I9GR0jXsWlgSfYB0s	cmtob892m003xc6qnqhmxp8lu	CUSTOMER	2026-10-15 14:25:15.801	okhttp/4.12.0	3d3d24c34f733e48	V2545	16	172.69.63.221	2026-10-08 14:25:15.802
cmv0fo8ew0002c69x7sk8fizl	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTUxODE4NywiZXhwIjoxNzkyMTIyOTg3LCJqdGkiOiI1YjliMjgyZS01MTJmLTRlYTEtYjg0NC1mZjllNjhjNTdiNDcifQ.FngaxEAxk2Fpab3oiZ8pMMU6IZZ2IMFhRV5T3bqQwVY	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-10-16 03:56:27.415	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.158.108.14	2026-10-09 03:56:27.416
cmv0foah10003c69xqq2492ka	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxNTE4MTkwLCJleHAiOjE3OTIxMjI5OTAsImp0aSI6Ijk1ODQ1MTQ4LTY3ZWEtNGQ3OC1hYTQyLTNmOGMzY2IzOTRkMCJ9.scdJq75dqKmo2u8x6WGGUMp9ixYEUlx7PzDU5EZX9d8	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-10-16 03:56:30.085	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.158.108.14	2026-10-09 03:56:30.085
cmv0fpc550007c69xgmid5oco	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXYwZnBjNHUwMDA1YzY5eGt6NnAzMzd4Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxNTE4MjM4LCJleHAiOjE3OTIxMjMwMzgsImp0aSI6ImQ0YjRhMzg5LWViZmEtNDI1MC05ZTdjLTMyMDc1ODcxNDlkMyJ9.VeSoGihpA3LZdwrKn1MK4Tzc41egLn29RTmMOYr0KWw	cmv0fpc4u0005c69xkz6p337x	CUSTOMER	2026-10-16 03:57:18.905	okhttp/4.12.0	76a67b7a07c84860	M2006C3MII	10	162.158.163.162	2026-10-09 03:57:18.906
cmv0fq5q00008c69xcqfqfgfj	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRvMTJ6N3EwMDAzYzZxbmdmZ3o1dTRjIiwicm9sZSI6IlZFTkRPUiIsImlhdCI6MTc5MTUxODI3NywiZXhwIjoxNzkyMTIzMDc3LCJqdGkiOiJmNGNlYzQ0NC1jNmYxLTQ0MjctOGM2OS0xOTNkMDFjYTZjM2MifQ.ke4x_0mlV7uu6Cq9miuaTUvCkBEd_lw6vvbXbHubhFs	cmto12z7q0003c6qngfgz5u4c	VENDOR	2026-10-16 03:57:57.24	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.158.108.14	2026-10-09 03:57:57.241
cmv0fqd6d0009c69xy7sya6bd	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXRudTN4dDgwMDN0YzZka21wYzlyeWNqIiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxNTE4Mjg2LCJleHAiOjE3OTIxMjMwODYsImp0aSI6IjkzNmM2ZjY5LTMyMTktNDNlYy1iYTBjLTFkM2JkZWVkNzFiYiJ9.FJoDArWZMWrHsKCl8ezAmMhrBFthAMfjG-h3AvCAQjI	cmtnu3xt8003tc6dkmpc9rycj	CUSTOMER	2026-10-16 03:58:06.9	okhttp/4.12.0	6cffaf43ba48a6d1	V2336	16	162.158.108.14	2026-10-09 03:58:06.901
cmv0fqywr000dc69xwt9h4qdr	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXYwZnF5d2swMDBiYzY5eGQ3NjBzaWU5Iiwicm9sZSI6IkNVU1RPTUVSIiwiaWF0IjoxNzkxNTE4MzE1LCJleHAiOjE3OTIxMjMxMTUsImp0aSI6IjhlNTgxYTJhLTBhNjItNDdkMi1iMTNkLWViZGFiMzNmMGVlZiJ9.ovbZHpvf38wJv1k_tM9qeWT-BK1EGuZBdSwvZqtobWw	cmv0fqywk000bc69xd760sie9	CUSTOMER	2026-10-16 03:58:35.067	okhttp/4.12.0	a7557389f4e13031	M2010J19CI	12	172.68.164.134	2026-10-09 03:58:35.068
\.


--
-- Data for Name: Review; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Review" (id, "customerId", "productId", "vendorId", "orderId", rating, comment, "imageUrl", "isFlagged", "isVisible", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: SearchLog; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."SearchLog" (id, "customerId", query, "districtId", "createdAt") FROM stdin;
cmto6bms40018c6qn4951g1ni	cmtmrl33p0027c6dknt5h6xfq	Strr	\N	2026-09-05 09:21:46.516
cmto6bo6w001ac6qn1py2tb0r	cmtmrl33p0027c6dknt5h6xfq	St	\N	2026-09-05 09:21:48.345
cmto6bp5q001cc6qnnunzkj86	cmtmrl33p0027c6dknt5h6xfq	Stee	\N	2026-09-05 09:21:49.599
cmto6bq83001ec6qn093btdpp	cmtmrl33p0027c6dknt5h6xfq	Steel	\N	2026-09-05 09:21:50.98
cmto8gg71001sc6qntqet4lna	cmtmrl33p0027c6dknt5h6xfq	Ste	\N	2026-09-05 10:21:30.493
cmtoauy4w001yc6qn8zaaabz0	cmtmrl33p0027c6dknt5h6xfq	Stee	\N	2026-09-05 11:28:46.16
cmtoauyco0020c6qnnwet1196	cmtmrl33p0027c6dknt5h6xfq	Steel	\N	2026-09-05 11:28:46.441
cmtoawoi30022c6qnlmlgsh0a	cmtmrl33p0027c6dknt5h6xfq	St	\N	2026-09-05 11:30:06.987
cmtoawoxp0024c6qn8cxxpzar	cmtmrl33p0027c6dknt5h6xfq	Stee	\N	2026-09-05 11:30:07.549
cmtoawpqt0026c6qndcec0276	cmtmrl33p0027c6dknt5h6xfq	Steel	\N	2026-09-05 11:30:08.597
cmtob0cgq002ec6qn4s9cqlx2	cmtmrl33p0027c6dknt5h6xfq	Stee	\N	2026-09-05 11:32:58.011
cmtob0de2002gc6qnj38uinf5	cmtmrl33p0027c6dknt5h6xfq	Steel	\N	2026-09-05 11:32:59.211
cmtob0m14002jc6qnrv728qt8	cmtmrl33p0027c6dknt5h6xfq	Steel	\N	2026-09-05 11:33:10.408
cmtob0mw8002lc6qnyezx2e9o	cmtmrl33p0027c6dknt5h6xfq	Steel w	\N	2026-09-05 11:33:11.528
cmtob0ncv002nc6qnx0pfxeg5	cmtmrl33p0027c6dknt5h6xfq	Steel wi	\N	2026-09-05 11:33:12.127
cmtob0nqp002pc6qntqy1esaa	cmtmrl33p0027c6dknt5h6xfq	Steel win	\N	2026-09-05 11:33:12.625
cmtob0o2u002rc6qn9ilp0v2p	cmtmrl33p0027c6dknt5h6xfq	Steel wind	\N	2026-09-05 11:33:13.048
cmtob0ogw002tc6qn1gbd4etv	cmtmrl33p0027c6dknt5h6xfq	Steel windo	\N	2026-09-05 11:33:13.568
cmtob0oyp002vc6qnnth3sk1k	cmtmrl33p0027c6dknt5h6xfq	Steel window	\N	2026-09-05 11:33:14.209
cmtob0pgg002xc6qncidrytb8	cmtmrl33p0027c6dknt5h6xfq	Steel windows	\N	2026-09-05 11:33:14.849
cmtob1syq0035c6qnhe17202v	cmtmrl33p0027c6dknt5h6xfq	Stre	\N	2026-09-05 11:34:06.05
cmtob1tff0037c6qn964l02j9	cmtmrl33p0027c6dknt5h6xfq	Strel	\N	2026-09-05 11:34:06.651
cmtob1u720039c6qnt0on3i1c	cmtmrl33p0027c6dknt5h6xfq	Strel	\N	2026-09-05 11:34:07.647
cmtob1uox003bc6qnf86ob5ju	cmtmrl33p0027c6dknt5h6xfq	Strel w	\N	2026-09-05 11:34:08.29
cmtob1v1m003dc6qn3jrnb8kt	cmtmrl33p0027c6dknt5h6xfq	Strel wi	\N	2026-09-05 11:34:08.746
cmtob1w0w003fc6qn3j81odyg	cmtmrl33p0027c6dknt5h6xfq	Strel wid	\N	2026-09-05 11:34:10.016
cmtob1whb003hc6qnxqj7ncc0	cmtmrl33p0027c6dknt5h6xfq	Strel wido	\N	2026-09-05 11:34:10.607
cmtob20iz003jc6qniu8i4quh	cmtmrl33p0027c6dknt5h6xfq	Strel win	\N	2026-09-05 11:34:15.852
cmtob20yr003lc6qnpzj62hog	cmtmrl33p0027c6dknt5h6xfq	Strel wind	\N	2026-09-05 11:34:16.419
cmtob21f2003nc6qnzxmhksju	cmtmrl33p0027c6dknt5h6xfq	Strel windo	\N	2026-09-05 11:34:17.007
cmtob222f003pc6qnzmq53f4r	cmtmrl33p0027c6dknt5h6xfq	Strel windows	\N	2026-09-05 11:34:17.847
cmtob27xm003rc6qnz017v8yu	cmtmrl33p0027c6dknt5h6xfq	Stel windows	\N	2026-09-05 11:34:25.45
cmtob28gt003tc6qnyxxb6fr1	cmtmrl33p0027c6dknt5h6xfq	Steel windows	\N	2026-09-05 11:34:26.141
cmtob2jtb003vc6qnr8sd0z4p	cmtmrl33p0027c6dknt5h6xfq	Steel window	\N	2026-09-05 11:34:40.847
cmtob8hon0041c6qn5zqe7v79	cmtob892m003xc6qnqhmxp8lu	St	\N	2026-09-05 11:39:18.024
cmtob8i8a0043c6qnxl6euk7w	cmtob892m003xc6qnqhmxp8lu	Stee	\N	2026-09-05 11:39:18.73
cmtob8iw10045c6qn2yzz464c	cmtob892m003xc6qnqhmxp8lu	Steel	\N	2026-09-05 11:39:19.586
cmtob8k680047c6qnzwnttc6y	cmtob892m003xc6qnqhmxp8lu	Steel	\N	2026-09-05 11:39:21.248
cmtob8ktb0049c6qnwa841094	cmtob892m003xc6qnqhmxp8lu	Steel w	\N	2026-09-05 11:39:22.077
cmtob8lpx004bc6qn4cslw8pz	cmtob892m003xc6qnqhmxp8lu	Steel wi	\N	2026-09-05 11:39:23.253
cmtob8lv9004dc6qniaturka6	cmtob892m003xc6qnqhmxp8lu	Steel win	\N	2026-09-05 11:39:23.445
cmtob8m50004fc6qnpqesodey	cmtob892m003xc6qnqhmxp8lu	Steel wind	\N	2026-09-05 11:39:23.796
cmtob8mly004hc6qn8jlh89ob	cmtob892m003xc6qnqhmxp8lu	Steel windo	\N	2026-09-05 11:39:24.406
cmtob8n4i004jc6qn3mimvwnx	cmtob892m003xc6qnqhmxp8lu	Steel window	\N	2026-09-05 11:39:25.074
cmtobdo6i004xc6qnlvrixxtv	cmtob892m003xc6qnqhmxp8lu	Stee	\N	2026-09-05 11:43:19.722
cmtobdoyl004zc6qnzr4pb92g	cmtob892m003xc6qnqhmxp8lu	Steel	\N	2026-09-05 11:43:20.733
cmtocdlsf0051c6qn3ow470n1	cmtob892m003xc6qnqhmxp8lu	St	\N	2026-09-05 12:11:16.237
cmtocdm460053c6qnyd8lekg5	cmtob892m003xc6qnqhmxp8lu	Stee	\N	2026-09-05 12:11:16.663
cmtoce9qf0056c6qnu2o39j31	cmtob892m003xc6qnqhmxp8lu	Sl	\N	2026-09-05 12:11:47.272
cmtoceai00058c6qn50r1wip8	cmtob892m003xc6qnqhmxp8lu	Sls	\N	2026-09-05 12:11:48.264
cmtoceb5g005ac6qn8i46xxgh	cmtob892m003xc6qnqhmxp8lu	Slsn	\N	2026-09-05 12:11:49.108
cmtocebj9005cc6qn7b9kzzgg	cmtob892m003xc6qnqhmxp8lu	Slsna	\N	2026-09-05 12:11:49.605
cmtocefgh005fc6qnxywpl42e	cmtob892m003xc6qnqhmxp8lu	Sn	\N	2026-09-05 12:11:54.689
cmtocefxx005hc6qnz8j0pc4y	cmtob892m003xc6qnqhmxp8lu	Sna	\N	2026-09-05 12:11:55.317
cmtocegm3005jc6qn22lnbbpt	cmtob892m003xc6qnqhmxp8lu	Snak	\N	2026-09-05 12:11:56.187
cmtocfu0q005lc6qnctokxem6	cmtob892m003xc6qnqhmxp8lu	Steel general	\N	2026-09-05 12:13:00.217
cmtocfvxk005nc6qnf0r2nxs0	cmtob892m003xc6qnqhmxp8lu	Steel general lllll	\N	2026-09-05 12:13:02.696
cmtocfy13005pc6qnlwhlzfbx	cmtob892m003xc6qnqhmxp8lu	Steel g	\N	2026-09-05 12:13:05.416
cmtocfyfg005rc6qnfgrhwxla	cmtob892m003xc6qnqhmxp8lu	Steel	\N	2026-09-05 12:13:05.932
cmtoea6cv005yc6qnos11ov4n	\N	Jenn	\N	2026-09-05 13:04:35.503
cmtoea6xk005zc6qn1jqfcs4i	\N	Jen	\N	2026-09-05 13:04:36.248
cmtoea7yh0060c6qn3dbltuyg	\N	Je	\N	2026-09-05 13:04:37.578
cmtoea8uz0061c6qn11ciq40d	\N	Jeenor	\N	2026-09-05 13:04:38.747
cmtoi89m90065c6qn8yq71rm7	\N	St	\N	2026-09-05 14:55:04.881
cmtoi8ay40066c6qnr7uvigdu	\N	Ste	\N	2026-09-05 14:55:06.604
cmtoi8bkc0067c6qnzdertqez	\N	Stee	\N	2026-09-05 14:55:07.405
cmtoi8ci00068c6qnnq85imw9	\N	Steel	\N	2026-09-05 14:55:08.617
cmtoiflgz006ec6qnmssrcayi	cmtoieuv2006ac6qnr401s5nu	St	\N	2026-09-05 15:00:46.835
cmtoiflyw006gc6qngleeumz2	cmtoieuv2006ac6qnr401s5nu	Stee	\N	2026-09-05 15:00:47.48
cmtoifn8b006ic6qn0pzs8s22	cmtoieuv2006ac6qnr401s5nu	Steel	\N	2026-09-05 15:00:49.115
cmtoj3fhs006kc6qnqfxgp5oi	cmtob892m003xc6qnqhmxp8lu	Steel general	\N	2026-09-05 15:19:18.833
cmtoj3hlp006mc6qn5anyo8y4	cmtob892m003xc6qnqhmxp8lu	Steel genera	\N	2026-09-05 15:19:21.564
cmtoj3i4s006oc6qn95yg852e	cmtob892m003xc6qnqhmxp8lu	Steel gene	\N	2026-09-05 15:19:22.253
cmtoj3iso006qc6qn5jcgklo1	cmtob892m003xc6qnqhmxp8lu	Steel g	\N	2026-09-05 15:19:23.112
cmtoj3j8y006sc6qntuvg1ijv	cmtob892m003xc6qnqhmxp8lu	Steel	\N	2026-09-05 15:19:23.699
cmtp229o9006tc6qny3uwuxl6	\N	Sn	\N	2026-09-06 00:10:17.337
cmtp22bmc006uc6qn8lzalnjh	\N	Sna	\N	2026-09-06 00:10:19.86
cmtp22rki006vc6qngvm4ll19	\N	St	\N	2026-09-06 00:10:40.53
cmtp22rzv006wc6qn1kd5wk8l	\N	Stee	\N	2026-09-06 00:10:41.083
cmtq1jati007ic6qnpefjbc8x	cmtq13ewh0078c6qnv0cluhfe	St	\N	2026-09-06 16:43:18.534
cmtq1jbgo007kc6qna6pi0tb9	cmtq13ewh0078c6qnv0cluhfe	Stee	\N	2026-09-06 16:43:19.368
cmtq1jc8q007mc6qnvjrvkyj2	cmtq13ewh0078c6qnv0cluhfe	Steel	\N	2026-09-06 16:43:20.378
cmtq20p37007oc6qn8gg03mu3	cmtq13ewh0078c6qnv0cluhfe	Stt	\N	2026-09-06 16:56:50.179
cmtq20qiv007qc6qnv0lz6gbg	cmtq13ewh0078c6qnv0cluhfe	St	\N	2026-09-06 16:56:52.039
cmtq20r8z007sc6qnitgceahg	cmtq13ewh0078c6qnv0cluhfe	Stee	\N	2026-09-06 16:56:52.977
cmtq23syp007yc6qnpu5xtucv	cmtq13ewh0078c6qnv0cluhfe	Zh	\N	2026-09-06 16:59:15.169
cmtq23tc10080c6qn3wjz2lg9	cmtq13ewh0078c6qnv0cluhfe	Zhi	\N	2026-09-06 16:59:15.649
cmtqgbzwx0081c6qn0l9pvczk	\N	Or	\N	2026-09-06 23:37:32.049
cmtqgc6n60082c6qndrtfhy1j	\N	Org	\N	2026-09-06 23:37:40.77
cmtqgc70g0083c6qnfswkcqa2	\N	Orgo	\N	2026-09-06 23:37:41.249
cmtqgc8zw0084c6qn9j0gskuw	\N	Organic	\N	2026-09-06 23:37:43.82
cmtqgcwxz0085c6qni4s8l6lo	\N	Organic p	\N	2026-09-06 23:38:14.854
cmtqgcxqt0086c6qnyrjtujej	\N	Organic pr	\N	2026-09-06 23:38:15.894
cmtqgcyf60087c6qndbnvikx6	\N	Organic pro	\N	2026-09-06 23:38:16.771
cmtqgczli0088c6qncnde9pn4	\N	Organic prod	\N	2026-09-06 23:38:18.294
cmtqgd1mr0089c6qny8z6ibh9	\N	Organic products	\N	2026-09-06 23:38:20.932
cmtqgd45x008ac6qnv3qwbjlc	\N	Organic products	\N	2026-09-06 23:38:24.213
cmtqgd4fw008bc6qnjcog2r4q	\N	Organic product	\N	2026-09-06 23:38:24.572
cmtqx9cu5008dc6qn2u9coznc	cmtq18z7d007cc6qnwch0now5	Th	\N	2026-09-07 07:31:22.3
cmtqx9d7d008fc6qnzwervewm	cmtq18z7d007cc6qnwch0now5	Thi	\N	2026-09-07 07:31:22.776
cmtqxhvux008mc6qnoxqs9rpx	cmtqxh2y4008ic6qngsyygee0	St	\N	2026-09-07 07:38:00.201
cmtqxhwev008oc6qnvotlr7j9	cmtqxh2y4008ic6qngsyygee0	Stee	\N	2026-09-07 07:38:00.919
cmtqxhxxe008qc6qno6bzky14	cmtqxh2y4008ic6qngsyygee0	Steel	\N	2026-09-07 07:38:02.883
cmtqxiax3008sc6qnqy9virlx	cmtqxh2y4008ic6qngsyygee0	Thi	\N	2026-09-07 07:38:19.719
cmtqxtqnf0092c6qney2qspdl	cmtqxh2y4008ic6qngsyygee0	St	\N	2026-09-07 07:47:13.323
cmtqxtqvd0094c6qnieo1zcbq	cmtqxh2y4008ic6qngsyygee0	Stee	\N	2026-09-07 07:47:13.609
cmtr9e4rq009cc6qnyk45vu2s	\N	Thi	\N	2026-09-07 13:11:00.518
cmttn56c5000ec60pcnyucubv	\N	El	\N	2026-09-09 05:11:29.621
cmttn56sw000fc60pxxfkgtw9	\N	Ele	\N	2026-09-09 05:11:30.225
cmttn73lk000hc60ph7xsctpb	cmtq13ewh0078c6qnv0cluhfe	St	\N	2026-09-09 05:12:59.384
cmttn7457000jc60pcpb6858p	cmtq13ewh0078c6qnv0cluhfe	Stee	\N	2026-09-09 05:13:00.091
cmttnbz6y000nc60pxitlz5l7	\N	Mak	\N	2026-09-09 05:16:46.94
cmttnbz7g000oc60pqbf1b5o3	\N	Make	\N	2026-09-09 05:16:46.956
cmttnbzfm000pc60ppbdniw1d	\N	Ma	\N	2026-09-09 05:16:47.267
cmttnc47e000qc60pk4ol6gkt	\N	Makeu	\N	2026-09-09 05:16:53.45
cmttnc4gs000rc60pwb8zl4b3	\N	Makeup	\N	2026-09-09 05:16:53.789
cmttnc829000sc60pr4yybd3t	\N	Be	\N	2026-09-09 05:16:58.449
cmttnc8f2000tc60pvdui3eu6	\N	Bea	\N	2026-09-09 05:16:58.911
cmttnc95f000uc60pquk1uhde	\N	Beau	\N	2026-09-09 05:16:59.86
cmttncpc3000vc60prabla6zc	\N	Ce	\N	2026-09-09 05:17:20.835
cmttncpwg000wc60p2oqzcpn9	\N	Cen	\N	2026-09-09 05:17:21.568
cmttncudk000xc60pwehr8ziq	\N	Cet	\N	2026-09-09 05:17:27.369
cmttncw1l000yc60pjrpki51q	\N	Cetr	\N	2026-09-09 05:17:29.53
cmttncwdj000zc60pt7tvp2nq	\N	Cetri	\N	2026-09-09 05:17:29.959
cmttncwnt0010c60p6eyshj8s	\N	Cetrin	\N	2026-09-09 05:17:30.329
cmttncx2j0011c60p5fp7od0b	\N	Cetring	\N	2026-09-09 05:17:30.859
cmtv74cpg000cc68csnt7tozn	cmtmoclyv0022c6dkyi415t8r	Sn	\N	2026-09-10 07:18:29.716
cmtv74ddv000ec68cdxdvl72n	cmtmoclyv0022c6dkyi415t8r	Sna	\N	2026-09-10 07:18:30.595
cmtv74e1v000gc68cis3bqdaw	cmtmoclyv0022c6dkyi415t8r	Snac	\N	2026-09-10 07:18:31.459
cmtv74ekc000ic68c0yr2tc4w	cmtmoclyv0022c6dkyi415t8r	Snack	\N	2026-09-10 07:18:32.125
cmtvdlfdx000sc68cxdxalfn0	cmtnu3xt8003tc6dkmpc9rycj	Jee	\N	2026-09-10 10:19:44.037
cmtvdlfxb000uc68cdkrkk96v	cmtnu3xt8003tc6dkmpc9rycj	Jee	\N	2026-09-10 10:19:44.736
cmtvmcq8e001ec68cmoh4ucko	cmtvlfvrl0016c68ctku1w5rk	Au	cmtns0y7d003qc6dkrd484hm1	2026-09-10 14:24:54.734
cmtvmcqhn001gc68c9ajeyjqw	cmtvlfvrl0016c68ctku1w5rk	Aut	cmtns0y7d003qc6dkrd484hm1	2026-09-10 14:24:55.068
cmtvmcse5001ic68ckva99elp	cmtvlfvrl0016c68ctku1w5rk	Auto	cmtns0y7d003qc6dkrd484hm1	2026-09-10 14:24:57.533
cmtvmftib001kc68cf2q1jchd	cmtvlfvrl0016c68ctku1w5rk	Su	cmtns0y7d003qc6dkrd484hm1	2026-09-10 14:27:18.947
cmtvmfwnq001mc68c4gfn045z	cmtvlfvrl0016c68ctku1w5rk	Au	cmtns0y7d003qc6dkrd484hm1	2026-09-10 14:27:23.031
cmtvmlohw001vc68czw1ie6p4	cmtvlfvrl0016c68ctku1w5rk	Au	cmtns0y7d003qc6dkrd484hm1	2026-09-10 14:31:52.388
cmtvmlqaf001xc68c2jwl1wke	cmtvlfvrl0016c68ctku1w5rk	Aut	cmtns0y7d003qc6dkrd484hm1	2026-09-10 14:31:54.711
cmtvmlqm0001zc68ca5ewv146	cmtvlfvrl0016c68ctku1w5rk	Auto	cmtns0y7d003qc6dkrd484hm1	2026-09-10 14:31:55.128
cmtvmytw90026c68cia1ut4ad	\N	Au	\N	2026-09-10 14:42:05.913
cmtvmyu3w0027c68cjb7b67n7	\N	Aut	\N	2026-09-10 14:42:06.189
cmtvmyu3z0028c68cj8s3qrr9	\N	Auto	\N	2026-09-10 14:42:06.191
cmtvn41gg002hc68cd0m5o1rf	\N	Auto	\N	2026-09-10 14:46:08.993
cmtvn41v5002ic68c8c2snj5h	\N	Auto ser	\N	2026-09-10 14:46:09.521
cmtvn4264002jc68cpdg1h61d	\N	Auto serv	\N	2026-09-10 14:46:09.916
cmtvn45oz002kc68cctf2dpue	\N	Auto se	\N	2026-09-10 14:46:14.483
cmtvnbuu9002pc68cfaahnwh4	\N	Pe	\N	2026-09-10 14:52:13.665
cmtvnbuva002qc68crj6wtmm4	\N	Pet	\N	2026-09-10 14:52:13.702
cmtvnbv42002rc68c23bdp2mk	\N	Peto	\N	2026-09-10 14:52:14.018
cmtvnbvmb002sc68cagompy7o	\N	Petol	\N	2026-09-10 14:52:14.675
cmtvnbxvc002tc68ci4n8gaas	\N	Petol	\N	2026-09-10 14:52:17.592
cmtvnbynt002uc68c6jupnm2d	\N	Petol b	\N	2026-09-10 14:52:18.617
cmtvnbyyw002vc68cd6yre0rt	\N	Petol bu	\N	2026-09-10 14:52:19.016
cmtvnbzab002wc68ccqwz6rdn	\N	Petol bun	\N	2026-09-10 14:52:19.428
cmtvnbzqh002xc68c8iq8mlsr	\N	Petol bunk	\N	2026-09-10 14:52:20.009
cmtvncdf8002yc68cfnvay0d1	\N	Pel bunk	\N	2026-09-10 14:52:37.748
cmtvncf3s002zc68cbxt1rr5i	\N	Pl bunk	\N	2026-09-10 14:52:39.929
cmtvnch200030c68c4kwisth6	\N	l bunk	\N	2026-09-10 14:52:42.456
cmtvnciak0031c68chm0307e9	\N	Ol bunk	\N	2026-09-10 14:52:44.06
cmtvncizk0032c68c7723p8hw	\N	Oel bunk	\N	2026-09-10 14:52:44.96
cmtvncjhc0033c68cph80ddk6	\N	Oetl bunk	\N	2026-09-10 14:52:45.601
cmtvncjzl0034c68chnp0rbik	\N	Oetol bunk	\N	2026-09-10 14:52:46.258
cmtvnckf10035c68cx2ik16sa	\N	Oetoll bunk	\N	2026-09-10 14:52:46.814
cmtvncmzs0036c68cb1hfdivi	\N	Otoll bunk	\N	2026-09-10 14:52:50.152
cmtvncnaf0037c68cjydkyneu	\N	toll bunk	\N	2026-09-10 14:52:50.536
cmtvnco0z0038c68c5somft5s	\N	Ptoll bunk	\N	2026-09-10 14:52:51.492
cmtvncp2c0039c68chn721uve	\N	Petoll bunk	\N	2026-09-10 14:52:52.837
cmtvncpf9003ac68cz22792m0	\N	Pettoll bunk	\N	2026-09-10 14:52:53.301
cmtvncuf7003bc68cslexvz29	\N	Pbunk	\N	2026-09-10 14:52:59.779
cmtvncw3r003cc68cqvdnh4nw	\N	Pebunk	\N	2026-09-10 14:53:01.959
cmtvncwp9003dc68cgfk1nx7i	\N	Petbunk	\N	2026-09-10 14:53:02.734
cmtvncymr003ec68cl7cz21h5	\N	Petrbunk	\N	2026-09-10 14:53:05.235
cmtvncz5t003fc68ce5vguzei	\N	Petrobunk	\N	2026-09-10 14:53:05.921
cmtvnd08w003gc68cxiv33xcg	\N	Petrolbunk	\N	2026-09-10 14:53:07.328
cmtvnd1kw003hc68chp842zz0	\N	Petrol bunk	\N	2026-09-10 14:53:09.057
cmtvnn2i4003ic68cc2npux6w	\N	Petrol bun	\N	2026-09-10 15:00:56.812
cmtvnn324003jc68cfu1w0rqk	\N	Pe	\N	2026-09-10 15:00:57.532
cmtvnn5c2003kc68c647rcfgy	\N	Au	\N	2026-09-10 15:01:00.483
cmtvnn5o0003lc68cqrg9v0x1	\N	Aut	\N	2026-09-10 15:01:00.913
cmtwnqbff0001c6kgo6lv6bh1	cmtmrl33p0027c6dknt5h6xfq	St	\N	2026-09-11 07:51:14.522
cmtwwkokw0008c68mhgnapita	cmtmrl33p0027c6dknt5h6xfq	Au	\N	2026-09-11 11:58:48.176
cmtwwqlxf000bc68m5tigj4od	\N	St	\N	2026-09-11 12:03:24.675
cmtwwqm8m000cc68mgcmnx8s0	\N	Ste	\N	2026-09-11 12:03:25.079
cmtwwqp4m000dc68mztlgdeq7	\N	Stel	\N	2026-09-11 12:03:28.822
cmtwwqrjv000ec68mhpvbr3m2	\N	Ste	\N	2026-09-11 12:03:31.963
cmtx2m0sp0006c63vptb60uiy	cmtx2lp6i0002c63v8xu2kvn8	Ster	\N	2026-09-11 14:47:48.362
cmtx2m2vp0008c63vlll3m0ck	cmtx2lp6i0002c63v8xu2kvn8	Ste	\N	2026-09-11 14:47:51.061
cmtx2m37c000ac63vkjse8r5c	cmtx2lp6i0002c63v8xu2kvn8	St	\N	2026-09-11 14:47:51.481
cmtx7y7zd000gc63vn6ixs18u	\N	Mi	\N	2026-09-11 17:17:15.625
cmtx7y8g5000hc63vzbmhdoqe	\N	Milk	\N	2026-09-11 17:17:16.229
cmtx7y9vo000ic63v1zdbntdk	\N	Mil	\N	2026-09-11 17:17:18.084
cmtx7ya7u000jc63vbojku650	\N	Mi	\N	2026-09-11 17:17:18.523
cmtyfrnnf000rc63v35vsdn1t	\N	St	\N	2026-09-12 13:43:52.443
cmtyfrnzk000sc63ve46od1hq	\N	Ste	\N	2026-09-12 13:43:52.881
cmtyfrp6o000tc63vd26svcg6	\N	Stel	\N	2026-09-12 13:43:54.433
cmtyfrs6p000uc63veozppw8u	\N	Ste	\N	2026-09-12 13:43:58.322
cmtyfrthr000vc63vw3gth1v2	\N	Stee	\N	2026-09-12 13:44:00.015
cmtyhc80r0010c63vvysgse7r	cmtoieuv2006ac6qnr401s5nu	Ga	\N	2026-09-12 14:27:51.579
cmtyhc8ei0012c63viozcz68g	cmtoieuv2006ac6qnr401s5nu	Gai	\N	2026-09-12 14:27:52.074
cmtyhc8ql0014c63vdhv4a017	cmtoieuv2006ac6qnr401s5nu	Gaid	\N	2026-09-12 14:27:52.509
cmtyhcddx0016c63vpko2378u	cmtoieuv2006ac6qnr401s5nu	Sw	\N	2026-09-12 14:27:58.533
cmtyhce1a0018c63vjt5pak4i	cmtoieuv2006ac6qnr401s5nu	Swi	\N	2026-09-12 14:27:59.373
cmtyhcecu001ac63v8g3x7duj	cmtoieuv2006ac6qnr401s5nu	Swin	\N	2026-09-12 14:27:59.791
cmtyhcera001cc63vr5fmrfuc	cmtoieuv2006ac6qnr401s5nu	Swing	\N	2026-09-12 14:28:00.31
cmtyhcfry001ec63vd3vek94i	cmtoieuv2006ac6qnr401s5nu	SEWING	\N	2026-09-12 14:28:01.631
cmtyhchww001gc63v7o9j3z64	cmtoieuv2006ac6qnr401s5nu	SEWING m	\N	2026-09-12 14:28:04.401
cmtyhcij4001ic63vu0qgdyhq	cmtoieuv2006ac6qnr401s5nu	SEWING mea	\N	2026-09-12 14:28:05.201
cmtyhcj4i001kc63vwuq4z2q8	cmtoieuv2006ac6qnr401s5nu	SEWING meac	\N	2026-09-12 14:28:05.97
cmtyhcjg9001mc63vd7jlrjza	cmtoieuv2006ac6qnr401s5nu	SEWING meach	\N	2026-09-12 14:28:06.393
cmtyhcjq6001oc63vye70baqy	cmtoieuv2006ac6qnr401s5nu	SEWING meachu	\N	2026-09-12 14:28:06.75
cmtyhck06001qc63vm9mvjlxb	cmtoieuv2006ac6qnr401s5nu	SEWING meachun	\N	2026-09-12 14:28:07.11
cmtyhckn0001sc63v8a4d5jb9	cmtoieuv2006ac6qnr401s5nu	SEWING machine	\N	2026-09-12 14:28:07.932
cmtyhcm3q001uc63v6xzw3ocd	cmtoieuv2006ac6qnr401s5nu	SEWING machine g	\N	2026-09-12 14:28:09.83
cmtyhcmda001wc63vb77bchem	cmtoieuv2006ac6qnr401s5nu	SEWING machine ga	\N	2026-09-12 14:28:10.174
cmtyhcmvj001yc63vj5frvfog	cmtoieuv2006ac6qnr401s5nu	SEWING machine gai	\N	2026-09-12 14:28:10.832
cmtyhcn5m0020c63vottncl1n	cmtoieuv2006ac6qnr401s5nu	SEWING machine gaid	\N	2026-09-12 14:28:11.195
cmtyi6rg60021c63vo3mjx2y6	\N	Ma	\N	2026-09-12 14:51:36.438
cmtyi6rpk0022c63vtpiw2hll	\N	Mad	\N	2026-09-12 14:51:36.776
cmtyjj0g10024c63vc54k7aa8	\N	Bo	\N	2026-09-12 15:29:07.585
cmtyjoiwz0026c63vlybykivt	cmtmrl33p0027c6dknt5h6xfq	Ma	\N	2026-09-12 15:33:24.803
cmtyjojig0028c63v2apfo3gs	cmtmrl33p0027c6dknt5h6xfq	Mali	\N	2026-09-12 15:33:25.576
cmtyjolsi002ac63vq1nfw1x3	cmtmrl33p0027c6dknt5h6xfq	Mal	\N	2026-09-12 15:33:28.53
cmtyjongs002cc63vj9mi37uk	cmtmrl33p0027c6dknt5h6xfq	Ma	\N	2026-09-12 15:33:30.7
cmtyk6xdf002dc63vu0e39xcz	\N	Su	cmtns0y7d003qc6dkrd484hm1	2026-09-12 15:47:43.348
cmtyk6xvj002ec63vps5gniv8	\N	Suga	cmtns0y7d003qc6dkrd484hm1	2026-09-12 15:47:44
cmtyk6y4b002fc63vh14ulyeb	\N	Sugar	cmtns0y7d003qc6dkrd484hm1	2026-09-12 15:47:44.315
cmtyk9u2m002kc63vnf9knwwl	cmtyk8ja2002gc63vyvx2sds3	ar	cmtns0y7d003qc6dkrd484hm1	2026-09-12 15:49:59.038
cmtyk9ywo002mc63vnyqvplfd	cmtyk8ja2002gc63vyvx2sds3	Ri	cmtns0y7d003qc6dkrd484hm1	2026-09-12 15:50:05.304
cmtyk9z7t002oc63v8nmva749	cmtyk8ja2002gc63vyvx2sds3	Ric	cmtns0y7d003qc6dkrd484hm1	2026-09-12 15:50:05.705
cmtyk9zho002qc63vujzcrxl6	cmtyk8ja2002gc63vyvx2sds3	Rice	cmtns0y7d003qc6dkrd484hm1	2026-09-12 15:50:06.061
cmtz8zknn002zc63vj3k43f1v	\N	Pu	\N	2026-09-13 03:21:50.675
cmtz8zlfr0030c63vl2z59rvm	\N	Puff	\N	2026-09-13 03:21:51.688
cmtz8zmjb0031c63va0obt6da	\N	Puff	\N	2026-09-13 03:21:53.112
cmtz8zn5z0032c63veyge6loj	\N	Puff p	\N	2026-09-13 03:21:53.927
cmtz8znoo0033c63vdtb5j4if	\N	Puff pa	\N	2026-09-13 03:21:54.601
cmtz8zo6s0034c63vlfrfvs0e	\N	Puff pan	\N	2026-09-13 03:21:55.252
cmtz8zom90035c63vv8slqv5g	\N	Puff pane	\N	2026-09-13 03:21:55.809
cmtz8zoz60036c63vfkvkmbgw	\N	Puff panel	\N	2026-09-13 03:21:56.274
cmtz8zpr40037c63vat30ds1k	\N	Puff panel	\N	2026-09-13 03:21:57.281
cmtz8zqka0038c63vgddodldt	\N	Puff panel s	\N	2026-09-13 03:21:58.33
cmtz8zr7a0039c63v6v7i94lu	\N	Puff panel sh	\N	2026-09-13 03:21:59.158
cmtz8zsaq003ac63vkao1yua5	\N	Puff panel sheet	\N	2026-09-13 03:22:00.578
cmtz8zsoh003bc63vyx6ybujv	\N	Puff panel sheets	\N	2026-09-13 03:22:01.073
cmu3xidlw0017c644g6o3pnsj	\N	GS	cmtns0y7d003qc6dkrd484hm1	2026-09-16 09:59:23.491
cmu3xk25q0018c6443g1m7frn	\N	GS centry	cmtns0y7d003qc6dkrd484hm1	2026-09-16 10:00:41.966
cmu3xk5fb0019c6444scz9jdm	\N	GS ce	cmtns0y7d003qc6dkrd484hm1	2026-09-16 10:00:46.199
cmu3xk5tx001ac644i3u0j5vp	\N	GS c	cmtns0y7d003qc6dkrd484hm1	2026-09-16 10:00:46.726
cmu3xk6a5001bc644oczskrqf	\N	GS	cmtns0y7d003qc6dkrd484hm1	2026-09-16 10:00:47.309
cmu3xk90y001cc644jh61zlg3	\N	GS sendering	cmtns0y7d003qc6dkrd484hm1	2026-09-16 10:00:50.866
cmu6chqwc001zc644t6psx0dg	cmu6chg81001vc644q7a5i134	Han	cmtns0y7d003qc6dkrd484hm1	2026-09-18 02:34:20.653
cmu6chr720021c644f6609zda	cmu6chg81001vc644q7a5i134	Hand	cmtns0y7d003qc6dkrd484hm1	2026-09-18 02:34:21.038
cmu6ci03q0023c644tim1tb02	cmu6chg81001vc644q7a5i134	Handma	cmtns0y7d003qc6dkrd484hm1	2026-09-18 02:34:32.582
cmu6ci0mk0025c6440ospm8kg	cmu6chg81001vc644q7a5i134	Handmade	cmtns0y7d003qc6dkrd484hm1	2026-09-18 02:34:33.261
cmu6ci6fw0027c644lmgzywbu	cmu6chg81001vc644q7a5i134	White	cmtns0y7d003qc6dkrd484hm1	2026-09-18 02:34:40.796
cmu73je5c000jc6u6zsuw1fgq	cmu73iqmh000fc6u6xx8ozhtp	Lap	\N	2026-09-18 15:11:27.072
cmu7mihjt000nc6u60g1t2swy	cmtmrl33p0027c6dknt5h6xfq	Ha	\N	2026-09-19 00:02:37.529
cmu7mii2q000pc6u6qyudcxzf	cmtmrl33p0027c6dknt5h6xfq	Han	\N	2026-09-19 00:02:38.211
cmu85qbs8000vc6u605jestos	\N	Egg	\N	2026-09-19 09:00:36.008
cmu85qdm3000wc6u6mx0kgetn	\N	Eg	\N	2026-09-19 09:00:38.38
cmu85qgsq000xc6u6lkcceccb	\N	Ve	\N	2026-09-19 09:00:42.506
cmu85qh2q000yc6u6ho7z5tnd	\N	Veg	\N	2026-09-19 09:00:42.866
cmuc2924r001yc6u67s8dg7o9	\N	To	\N	2026-09-22 02:34:16.203
cmuc292j1001zc6u60sn1p16g	\N	Tom	\N	2026-09-22 02:34:16.718
cmuc293tn0020c6u6iv89ef3q	\N	Tomo	\N	2026-09-22 02:34:18.396
cmuc295dd0021c6u6iuot6nhq	\N	Tomott	\N	2026-09-22 02:34:20.401
cmuc295x60022c6u616yfw6b5	\N	Tomotto	\N	2026-09-22 02:34:21.114
cmuc5fy300023c6u69kq9n6up	\N	To	cmtns0y7d003qc6dkrd484hm1	2026-09-22 04:03:36.396
cmuc5fypm0024c6u6ik5fehbi	\N	Tom	cmtns0y7d003qc6dkrd484hm1	2026-09-22 04:03:37.211
cmuc5g01g0025c6u6swgxsph4	\N	To	cmtns0y7d003qc6dkrd484hm1	2026-09-22 04:03:38.933
cmuc5ge610026c6u6yeqsj7zb	\N	To	\N	2026-09-22 04:03:57.241
cmucohj7f002ic6u6z40rk8n8	cmu6ckauf0029c6445fzyiihf	Wa	cmtns0y7d003qc6dkrd484hm1	2026-09-22 12:56:43.132
cmucohlkg002kc6u6itiip2zz	cmu6ckauf0029c6445fzyiihf	Water	cmtns0y7d003qc6dkrd484hm1	2026-09-22 12:56:46.193
cmucoi6f9002mc6u6q6m97zpg	cmu6ckauf0029c6445fzyiihf	Water	\N	2026-09-22 12:57:13.222
cmucrgl3o002pc6u6ud5o4khy	\N	Co	cmtns0y7d003qc6dkrd484hm1	2026-09-22 14:19:57.78
cmucrgl9y002qc6u6hc3tfelf	\N	Cos	cmtns0y7d003qc6dkrd484hm1	2026-09-22 14:19:58.007
cmucrgm13002rc6u6rdet2df2	\N	Cosm	cmtns0y7d003qc6dkrd484hm1	2026-09-22 14:19:58.983
cmucrgmc2002sc6u63901ajfr	\N	Cosme	cmtns0y7d003qc6dkrd484hm1	2026-09-22 14:19:59.378
cmucrgmq3002tc6u6di3ivhz1	\N	Cosmet	cmtns0y7d003qc6dkrd484hm1	2026-09-22 14:19:59.884
cmucrgna7002uc6u67nvn8gqk	\N	Cosmetics	cmtns0y7d003qc6dkrd484hm1	2026-09-22 14:20:00.608
cmuczjlai002vc6u6zqx2s844	\N	Rice	cmryso2s2001ac6g90qlx1tb5	2026-09-22 18:06:14.921
cmue4rqk2002yc6u6z684649v	cmtmoclyv0022c6dkyi415t8r	Bes	\N	2026-09-23 13:20:19.25
cmue4rrfv0030c6u6sa30dqo2	cmtmoclyv0022c6dkyi415t8r	Beauty	\N	2026-09-23 13:20:20.396
cmunq6q00001ec6uvzj56e433	cmtmrl33p0027c6dknt5h6xfq	St	\N	2026-09-30 06:29:45.888
cmunq6qcw001gc6uvu44u3e9d	cmtmrl33p0027c6dknt5h6xfq	Ste	\N	2026-09-30 06:29:46.352
cmunq6ss9001ic6uv6x5x93va	cmtmrl33p0027c6dknt5h6xfq	St	\N	2026-09-30 06:29:49.497
cmunq6v7n001kc6uvfb7h7lzk	cmtmrl33p0027c6dknt5h6xfq	Wa	\N	2026-09-30 06:29:52.643
cmunq6w1g001mc6uvbhuyn89h	cmtmrl33p0027c6dknt5h6xfq	Water	\N	2026-09-30 06:29:53.717
cmupbcgyl0016c6i7nmoacdqg	cmupba85c0012c6i771dg695z	PO	\N	2026-10-01 09:09:52.221
cmupbch540018c6i7dbq6buek	cmupba85c0012c6i771dg695z	PORE	\N	2026-10-01 09:09:52.457
cmupbchnc001ac6i7qcgtm0m4	cmupba85c0012c6i771dg695z	PORE	\N	2026-10-01 09:09:53.113
cmupbcspe001cc6i78opd3uba	cmupba85c0012c6i771dg695z	PORE R	\N	2026-10-01 09:10:07.441
cmupbcsyo001ec6i7g4zgjkwj	cmupba85c0012c6i771dg695z	PORE RE	\N	2026-10-01 09:10:07.777
cmupbctyg001gc6i7tfx3iyr4	cmupba85c0012c6i771dg695z	PORE REF	\N	2026-10-01 09:10:09.064
cmupbcu87001ic6i7vhm42hdw	cmupba85c0012c6i771dg695z	PORE REFI	\N	2026-10-01 09:10:09.415
cmupbcx63001kc6i7ybk9limx	cmupba85c0012c6i771dg695z	PORE REFIN	\N	2026-10-01 09:10:13.227
cmupbcxql001mc6i7tabcv2i6	cmupba85c0012c6i771dg695z	PORE REFINE	\N	2026-10-01 09:10:13.966
cmupbcy47001oc6i7z0uxemtc	cmupba85c0012c6i771dg695z	PORE REFINE	\N	2026-10-01 09:10:14.455
cmupbczbr001qc6i7d0iuxwcl	cmupba85c0012c6i771dg695z	PORE REFINE T	\N	2026-10-01 09:10:16.022
cmupbczm4001sc6i7ttizhq6k	cmupba85c0012c6i771dg695z	PORE REFINE TO	\N	2026-10-01 09:10:16.396
cmupbczwo001uc6i7djoxa9ix	cmupba85c0012c6i771dg695z	PORE REFINE TON	\N	2026-10-01 09:10:16.776
cmupbd07w001wc6i7vkosuc97	cmupba85c0012c6i771dg695z	PORE REFINE TONE	\N	2026-10-01 09:10:17.181
cmupbd0j0001yc6i7wx5ikgcb	cmupba85c0012c6i771dg695z	PORE REFINE TONER	\N	2026-10-01 09:10:17.58
cmutq3l930008c61pmc0dkbwo	\N	Ct	\N	2026-10-04 11:13:56.823
cmutq3mb00009c61pzbncg4ji	\N	Ch	\N	2026-10-04 11:13:58.189
cmutq3mz8000ac61p5zsb3v60	\N	Chee	\N	2026-10-04 11:13:59.06
cmutq3nii000bc61p7z5w0k44	\N	Cheese	\N	2026-10-04 11:13:59.755
cmuuzekg40019c61pyd5dl8kn	cmuo0v8ay0009c6i7yrv0ttra	Me	cmtns0y7d003qc6dkrd484hm1	2026-10-05 08:22:11.717
cmuuzekqb001bc61p3n6ciikx	cmuo0v8ay0009c6i7yrv0ttra	Meh	cmtns0y7d003qc6dkrd484hm1	2026-10-05 08:22:12.084
cmuuzekz7001dc61pz57kprco	cmuo0v8ay0009c6i7yrv0ttra	Meha	cmtns0y7d003qc6dkrd484hm1	2026-10-05 08:22:12.404
cmuuzelji001fc61pa1t14bda	cmuo0v8ay0009c6i7yrv0ttra	Mehan	cmtns0y7d003qc6dkrd484hm1	2026-10-05 08:22:13.134
cmuuzelwt001hc61pi3f8i621	cmuo0v8ay0009c6i7yrv0ttra	Mehand	cmtns0y7d003qc6dkrd484hm1	2026-10-05 08:22:13.613
cmuuzem6s001jc61p0n8p0xyy	cmuo0v8ay0009c6i7yrv0ttra	Mehandi	cmtns0y7d003qc6dkrd484hm1	2026-10-05 08:22:13.973
cmuv6hicp001vc61p81oag1g3	cmuv6h7z4001rc61p12b47c8x	Bis	cmtns0y7d003qc6dkrd484hm1	2026-10-05 11:40:26.282
cmuv6hink001xc61pm268zboc	cmuv6h7z4001rc61p12b47c8x	Bisc	cmtns0y7d003qc6dkrd484hm1	2026-10-05 11:40:26.673
cmuv6hj5a001zc61p30uzhyze	cmuv6h7z4001rc61p12b47c8x	Biscut	cmtns0y7d003qc6dkrd484hm1	2026-10-05 11:40:27.31
cmuv7lm9l002sc61pr9vr4ur4	cmuo0v8ay0009c6i7yrv0ttra	Boomika	cmtns0y7d003qc6dkrd484hm1	2026-10-05 12:11:37.593
cmuv7mfgo002tc61p2qgixgjl	\N	Boo	\N	2026-10-05 12:12:15.432
cmuv8fz480032c61piewfbcmq	cmuv886sy002yc61ph3wajcek	Milk	\N	2026-10-05 12:35:13.928
cmuvert2x0039c61p81r03e4v	\N	Chart	\N	2026-10-05 15:32:23.664
cmuvert3i003ac61p8q3kem10	\N	Chat	\N	2026-10-05 15:32:23.675
cmuzmpkem000lc6l3388q9zr0	cmtob892m003xc6qnqhmxp8lu	Steel general	\N	2026-10-08 14:25:40.75
cmuzmprdm000nc6l3ig29580f	cmtob892m003xc6qnqhmxp8lu	Steel general	\N	2026-10-08 14:25:49.787
cmuzmz7ju000pc6l3y8zd5269	cmtob892m003xc6qnqhmxp8lu	Ja	\N	2026-10-08 14:33:10.65
cmuzmz88b000rc6l33q8625p8	cmtob892m003xc6qnqhmxp8lu	Janna	\N	2026-10-08 14:33:11.531
cmuzmzagl000tc6l3iayxfczd	cmtob892m003xc6qnqhmxp8lu	Jan	\N	2026-10-08 14:33:14.422
cmuzmzcz0000vc6l3jcgeos89	cmtob892m003xc6qnqhmxp8lu	Moo	\N	2026-10-08 14:33:17.677
cmuzmzdh1000xc6l3cp12w7yd	cmtob892m003xc6qnqhmxp8lu	Moor	\N	2026-10-08 14:33:18.326
cmuzmzdxs000zc6l3qg9czniw	cmtob892m003xc6qnqhmxp8lu	Moorty	\N	2026-10-08 14:33:18.928
cmuzmzhxu0011c6l37pdqc52y	cmtob892m003xc6qnqhmxp8lu	Moo	\N	2026-10-08 14:33:24.114
cmuzmzibn0013c6l3joy656p8	cmtob892m003xc6qnqhmxp8lu	Moot	\N	2026-10-08 14:33:24.612
cmuzmziky0015c6l3d0ci8v9v	cmtob892m003xc6qnqhmxp8lu	Mooth	\N	2026-10-08 14:33:24.946
cmuzmzjt00017c6l3z4kyxh7u	cmtob892m003xc6qnqhmxp8lu	Moothi	\N	2026-10-08 14:33:26.533
cmuzmzle40019c6l3il61pd76	cmtob892m003xc6qnqhmxp8lu	Mo	\N	2026-10-08 14:33:28.589
cmuzn197e001bc6l340wj3dtl	cmtob892m003xc6qnqhmxp8lu	Wte	\N	2026-10-08 14:34:46.106
cmuzn19gs001dc6l3ukbm1jty	cmtob892m003xc6qnqhmxp8lu	Wter	\N	2026-10-08 14:34:46.445
cmuzn1br3001fc6l3oboijij8	cmtob892m003xc6qnqhmxp8lu	Wa	\N	2026-10-08 14:34:49.408
cmuzn1c44001hc6l3snh0089u	cmtob892m003xc6qnqhmxp8lu	War	\N	2026-10-08 14:34:49.877
cmuzn1dc2001jc6l3rx58u7sj	cmtob892m003xc6qnqhmxp8lu	Wa	\N	2026-10-08 14:34:51.458
cmuzn1e77001lc6l33xxm0sk3	cmtob892m003xc6qnqhmxp8lu	Water	\N	2026-10-08 14:34:52.58
cmuzn1o3n001nc6l3tb262gpj	cmtob892m003xc6qnqhmxp8lu	Ele	\N	2026-10-08 14:35:05.411
cmuzn1ova001pc6l3nap7k09x	cmtob892m003xc6qnqhmxp8lu	Elec	\N	2026-10-08 14:35:06.406
cmuzn1p78001rc6l3nd4p8046	cmtob892m003xc6qnqhmxp8lu	Elect	\N	2026-10-08 14:35:06.837
cmuzn1r0a001tc6l3hz02k4im	cmtob892m003xc6qnqhmxp8lu	Electri	\N	2026-10-08 14:35:09.179
cmuzq2teq0000c6nfgprm92e9	\N	a	\N	2026-10-08 15:59:57.795
\.


--
-- Data for Name: Staff; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Staff" (id, code, name, phone, email, designation, "districtId", "areaId", "isActive", "createdAt", "updatedAt") FROM stdin;
cmunw9y9j0002c6h0whxq608u	STF-001	test	9344193569	jeena2284@gmail.com	Field Executive	\N	\N	t	2026-09-30 09:20:14.263	2026-09-30 09:20:14.263
cmuqpyyaa0002c6dq1nbd89ao	STF-003	test3	9344193561	jeena22843@gmail.com	Field Marketing Executive	\N	\N	t	2026-10-02 08:47:01.906	2026-10-02 08:47:01.906
cmuqu2psv001tc69b845ijpqi	STF-004	RAVICHANDRAN	9944533403	cm.ravi23@gmail.com	Managing Director	\N	\N	t	2026-10-02 10:41:56	2026-10-02 10:41:56
cmuqu5w5g001xc69bktrr87gk	STF-005	SARANYA DEVI	9080359113	saranyanikhilisha@gmail.com	Branch Cashier	\N	\N	t	2026-10-02 10:44:24.197	2026-10-02 10:44:24.197
cmuqujg4q001zc69bxnxrwvl9	STF-006	PREMKUMAR	7708696683	premkumargsp@gmail.com	Sales Manager	\N	\N	t	2026-10-02 10:54:56.618	2026-10-02 10:54:56.618
cmuquln1w0021c69b7ifvhg8l	STF-007	GANESH RAJA	6381194463	ganesh.cadd1994@gmail.com	Branch Manager	\N	\N	t	2026-10-02 10:56:38.9	2026-10-02 10:56:38.9
cmuqjy7ek0005c6switm6eehx	STF-002	BOOMIKA	9842712478	boomikar3745@gmail.com	Branch Cashier	\N	\N	t	2026-10-02 05:58:29.372	2026-10-02 10:57:01.171
cmuqup3tj0023c69bc5uutjz1	STF-008	HARISH KUMAR	8610319103	harishksk.1996@gmail.com	Sales Manager	\N	\N	t	2026-10-02 10:59:20.6	2026-10-02 10:59:20.6
cmuqv0qne0025c69b33zgh9jc	STF-009	NIVATHA	6381510489	nivatha98@gmail.com	Branch Cashier	\N	\N	t	2026-10-02 11:08:23.403	2026-10-02 11:08:23.403
cmurxk9i6002lc69bv45gywsc	STF-010	MOHAN KUMAR	9865862570	duraimohan18@gmail.com	Branch Manager	\N	\N	t	2026-10-03 05:07:19.711	2026-10-03 05:07:19.711
cmurxs1bj002nc69bxcn21dip	STF-011	HARIHARAN	6374127585	hirahari6374@gmail.com	Sales Manager	\N	\N	t	2026-10-03 05:13:22.351	2026-10-03 05:13:22.351
cmus27dcf002rc69bw7hq4n92	STF-012	SRINIVASAN	9865930083	windotsri@gmail.com	Incharge	\N	\N	t	2026-10-03 07:17:16.239	2026-10-03 07:17:16.239
cmus2fmpl002vc69bo4g558bt	STF-013	MOTHIZAN	6380650638	mothilora@gmail.com	Incharge	\N	\N	t	2026-10-03 07:23:41.625	2026-10-03 07:23:41.625
cmuv6tnsx0029c61pjux90zvp	STF-014	TEJA	8838587317	mteja8666@gmail.com	Branch Manager	\N	\N	t	2026-10-05 11:49:53.217	2026-10-05 11:49:53.217
\.


--
-- Data for Name: StaffAuditLog; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."StaffAuditLog" (id, "staffId", action, platform, "deviceInfo", "ipAddress", metadata, "createdAt") FROM stdin;
cmuqrfo7r0001c69bj1sq4zrd	cmuqpyyaa0002c6dq1nbd89ao	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 09:28:01.624
cmuqrg1ho0003c69bmpr5mcyb	cmuqpyyaa0002c6dq1nbd89ao	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 09:28:18.828
cmuqrg4bn0005c69bbyjeiqgv	cmuqpyyaa0002c6dq1nbd89ao	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 09:28:22.5
cmuqrgehe0007c69b54ghtkjy	cmuqpyyaa0002c6dq1nbd89ao	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 09:28:35.667
cmuqrvbib000bc69biu3zwpja	cmuqpyyaa0002c6dq1nbd89ao	QR_SCAN	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36	\N	\N	\N	2026-10-02 09:40:11.651
cmuqsjysd000dc69bdfuednh5	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 09:59:21.565
cmuqskfxz000fc69bmt1qk7xl	cmuqpyyaa0002c6dq1nbd89ao	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 09:59:43.799
cmuqsl89v000hc69bcvz8esdv	cmuqpyyaa0002c6dq1nbd89ao	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:00:20.516
cmuqsml1p000jc69b8uv8jiao	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:01:23.725
cmuqsmz67000lc69b18xu8qks	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:01:42.032
cmuqso1iu000nc69b51hn11t4	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:02:31.734
cmuqsotja000pc69b10z9fgvs	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:03:08.039
cmuqspvko000rc69b9a87wlc8	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:03:57.336
cmuqsr3u4000tc69bxc86ypjd	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:04:54.7
cmuqt3nvc000vc69b32q0tney	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:14:40.537
cmuqt5az3000xc69btm0uhehw	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:15:57.135
cmuqt8iih0010c69blg7hvllk	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:18:26.873
cmuqt90nt0012c69bwnff6woy	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:18:50.393
cmuqtanf90014c69bzwrejwkl	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:20:06.549
cmuqtb4qd0018c69bsydu8r9o	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:20:28.981
cmuqtbar6001ac69bydvr8whc	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:20:36.787
cmuqtbgsq001cc69b5und2qzr	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:20:44.619
cmuqtdhmm001ec69bbenal9mv	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:22:19.007
cmuqti2my001gc69bxsqgqb8h	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:25:52.859
cmuqtl6f4001jc69bwyyv3r0v	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:28:17.728
cmuqtlxst001lc69b49c04tog	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:28:53.214
cmuqtmksc001nc69b2rzxpy9m	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:29:23.004
cmuqu36k1001vc69bdc4cyw0l	cmuqu2psv001tc69b845ijpqi	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 10:42:17.713
cmuqv1sh50027c69b5bjgw77a	cmuqv0qne0025c69b33zgh9jc	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 11:09:12.426
cmuqvrg0k0029c69bp8tsr2fc	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-02 11:29:09.333
cmurupmrq002ec69b0xg591d2	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-03 03:47:31.334
cmurx4wyd002hc69btfjrr0ea	cmuqv0qne0025c69b33zgh9jc	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-03 04:55:23.605
cmurx5bi0002jc69bt8hchqye	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-03 04:55:42.457
cmurz1i6x002pc69bw9jncx1k	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-03 05:48:43.737
cmus296jd002tc69bksww0514	cmus27dcf002rc69bw7hq4n92	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-03 07:18:40.729
cmus2yafx002yc69bbk1fn3wr	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-03 07:38:12.19
cmus2yfdq0030c69bwt0ktt3w	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-03 07:38:18.59
cmuuqhnwr000dc61pmywwmevd	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-05 04:12:39.627
cmuuwke5n000pc61pq86g7j1y	cmuqjy7ek0005c6switm6eehx	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-05 07:02:44.651
cmuv6fost001pc61pihyq25q2	cmuqu5w5g001xc69bktrr87gk	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-05 11:39:01.326
cmuv6ysd7002bc61p87020lhf	cmuv6tnsx0029c61pjux90zvp	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-05 11:53:52.412
cmuv86kz6002vc61pt41soenz	cmuqu5w5g001xc69bktrr87gk	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-05 12:27:55.698
cmuvg4en1004ec61pdpflcx49	cmuqv0qne0025c69b33zgh9jc	QR_SCAN	Mozilla/5.0 (Linux; Android 14; V2416) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/15.0.2.1	\N	\N	\N	2026-10-05 16:10:11.101
cmuvg62kk004gc61pnunqlebh	cmuqv0qne0025c69b33zgh9jc	QR_SCAN	Mozilla/5.0 (Linux; Android 14; V2416) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/15.0.2.1	\N	\N	\N	2026-10-05 16:11:28.773
cmuvg7z84004ic61p176s2ww9	cmuqv0qne0025c69b33zgh9jc	QR_SCAN	Mozilla/5.0 (Linux; Android 14; V2416) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/15.0.2.1	\N	\N	\N	2026-10-05 16:12:57.748
cmuwmelsq000bc6l3vfkq2a6r	cmuqu2psv001tc69b845ijpqi	LINK_CLICK	Web	Chrome 128 / Windows 11	106.195.42.89	{"source":"Admin Portal Simulator","referrer":"qr-campaign"}	2026-10-06 11:53:50.81
cmuwmem7v000dc6l3oaqjstl8	cmuqu2psv001tc69b845ijpqi	QR_SCAN	Android	Samsung Galaxy S23 (Android 14)	106.195.42.89	{"source":"Admin Portal Simulator","referrer":"qr-campaign"}	2026-10-06 11:53:51.355
cmv0fmnw90001c69xmd5rvbyu	cmurxk9i6002lc69bv45gywsc	QR_SCAN	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	\N	\N	\N	2026-10-09 03:55:14.167
\.


--
-- Data for Name: StaticPage; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."StaticPage" (id, slug, title, content, "isActive", "updatedAt") FROM stdin;
\.


--
-- Data for Name: SuperAdmin; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."SuperAdmin" (id, email, "passwordHash", name, "isActive", "twoFaEnabled", "twoFaSecret", "createdAt", "updatedAt") FROM stdin;
cmtlr19vc0000c695n8dulqfn	admin@alltimemarket.in	$2a$12$orBT.w5mwe9beb9c/j4FqeN3Hglk1gBF.Ur7VGGuKvljFZni6j8GG	Super Admin	t	f	\N	2026-09-03 16:38:16.633	2026-09-03 16:38:16.633
\.


--
-- Data for Name: SupportTicket; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."SupportTicket" (id, "customerId", "orderId", subject, message, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Vendor; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Vendor" (id, "areaId", email, "passwordHash", "shopName", code, slug, description, "logoUrl", "bannerUrl", address, landmark, latitude, longitude, phone, "fssaiNumber", "gstNumber", "fssaiDocUrl", "gstDocUrl", "bankAccountNo", "bankIfsc", "bankHolderName", status, "rejectionReason", "minOrderValue", "deliveryRadius", "isOpen", "operatingHours", rating, "ratingCount", "approvedAt", "approvedBy", "createdAt", "updatedAt", "districtId", "customerId", "staffId", "staffReferralCode", "shopCategory") FROM stdin;
cmu01cq6w003qc63v1va7veeo	cmto12z7k0001c6qnenvc4c87	Sabarisuryaprakash@gmail.com	$2a$10$JMLMFFYMvoLmeYfduNz/aeJppcdUSfy3AfAhYHDg7fQMkUZ9YF65u	Pet shop	VND-69H1	pet-shop		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/72dd413c-fc32-4852-b7de-38e498a4ae48.webp	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/a804a8f4-0700-4136-9a2b-80d4946bac44.webp	16/6,kamarajar street,\nT. N. Palayam 	Anna silai	11.5037578	77.3870987	9788828179					32965602773	SBIN0002278	Suryaprakash L	APPROVED	\N	0.000000000000000000000000000000	5	t	\N	0	0	2026-09-13 16:35:53.622	SYSTEM_AUTO_APPROVE	2026-09-13 16:35:53.624	2026-10-01 18:48:32.617	cmtns0y7d003qc6dkrd484hm1	cmu01265v003kc63vin8jkqo4	\N	\N	\N
cmtx00p2d000qc68m99b0r0ga	cmto12z7k0001c6qnenvc4c87	soniyashanmugam1725@gmail.com	$2a$10$xC/kQqAPXC05hC6mWTzB8.R/CHb45gosWYbZ10n8RLWSmhUY3UiF2	Iniyal boutique	VND-0DQ0	iniyal-boutique	Dress sales and stitching	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/567027dc-20d2-4843-8069-b1d4f4e0cce6.webp		287, indhara nagar, kowndampalayam,\nT. N. Palayam(po),\nGobi(TK),\nErode(DT),\nPincode 638506	Manoj Petrol bunk	11.5079459	77.3803523	9344938459					33335032494	SBIN0002278	Soniya	APPROVED	\N	0.000000000000000000000000000000	5	t	\N	0	0	2026-09-11 13:35:14.147	SYSTEM_AUTO_APPROVE	2026-09-11 13:35:14.149	2026-10-01 18:48:32.624	cmtns0y7d003qc6dkrd484hm1	cmtwzsg5a000kc68mg01auon4	\N	\N	\N
cmutexr6h0004c61pxym4in29	cmunrox3v004mc6uvcbaqmj8f	mothilora@gmail.com	$2a$10$Wmval.kTHm1.GFbABWfEtuSTaRnlVJY1ZusQ5x43QfWCtwRalwjY.	A to Z Service 	VND-449R	a-to-z-service-	\N	\N	\N	Tn palayam 	\N	\N	\N	7373479123	\N	\N	\N	\N	\N	\N	\N	APPROVED	\N	0.000000000000000000000000000000	5	t	\N	0	0	2026-10-04 06:01:28.792	cmtlr19vc0000c695n8dulqfn	2026-10-04 06:01:28.793	2026-10-04 06:01:28.793	cmtns0y7d003qc6dkrd484hm1	cmutexr3e0001c61p5lwz160m	\N	Ravichandran Muthusamy 	\N
cmuntrw870003c683w0pwcr8b	cmunrot04002sc6uvwi03p8sk	shop@gmail.com	$2a$10$XSLsN0DFJdOG0HcCGy0P9.iYJDzvj6ZTue7leySfqF/DHCajTkuN.	testing shop	VND-62AS	testing-shop	\N	\N	\N	Harur	\N	\N	\N	6381027847	\N	\N	\N	\N	\N	\N	\N	APPROVED	\N	0.000000000000000000000000000000	5	t	\N	0	0	2026-09-30 08:10:12.583	cmtlr19vc0000c695n8dulqfn	2026-09-30 08:10:12.584	2026-09-30 08:10:12.584	cmtns0y7d003qc6dkrd484hm1	cmuntrw5o0000c683ml9jqd1l	\N	\N	\N
cmto6hp41001ic6qnofm37rw5	cmto12z7k0001c6qnenvc4c87	Zhidimensions@gmail.com	$2a$10$ZEzGkhp.vc4Tuam7iCDNlOI4RVH/gfrbDyb14xnjVTA37af0YMlZ2	ZHI DIMENSIONS 	VND-PRXX	zhi-dimensions-	Steel products 	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/48073c34-be36-4a26-8c9b-639cd43ca46d.webp	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/b0e2f8da-c0ad-4ee8-bfd3-4418fd3b18f4.webp	76,sathy-athani mainroad\nVaniputhur 638506\n	Mainroad	11.5050733	77.3602967	9865930083					23220200002050	FDRL0002322	Srinivasan 	APPROVED	\N	0.000000000000000000000000000000	50	t	\N	0	0	2026-09-05 09:26:29.473	SYSTEM_AUTO_APPROVE	2026-09-05 09:26:29.474	2026-10-01 18:48:32.592	cmtns0y7d003qc6dkrd484hm1	cmtmrl33p0027c6dknt5h6xfq	\N	\N	\N
cmtq2233s007uc6qn00o22gvp	cmto12z7k0001c6qnenvc4c87	Mothigazhl@gmail.com	$2a$10$8IG7PZnMdVkc1J1l7tJB9elBjJK3LE2KOhfUOS/t4mhdOW24ZebQG	THIGAZHL NALANGU MAAVU	VND-K0HC	thigazhl-nalangu-maavu	Organic products 	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/aa1dd102-f917-4ffc-be85-0312012c23cf.webp		Maint.road\nVaniputhur.638506	\N	11.5066044	77.3616894	9944932484					000087601068	IDIB0PLB001	Chandrika	APPROVED	\N	0.000000000000000000000000000000	50	t	\N	0	0	2026-09-06 16:57:54.999	SYSTEM_AUTO_APPROVE	2026-09-06 16:57:55	2026-10-01 18:48:32.601	cmtns0y7d003qc6dkrd484hm1	cmtq18z7d007cc6qnwch0now5	\N	\N	\N
cmtvmks9t001pc68cu38x9lc4	cmto12z7k0001c6qnenvc4c87	anbur8239@gmail.com	$2a$10$2gMFb3fbUDSwM/P5pOE2lOrHFDW8F/ihaeQW.xF31EL2IAUvyhWhG	Auto sarvies	VND-464R	auto-sarvies		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/4738974e-d0c9-4852-8725-55c78422b66a.webp	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/f6ba2ff9-84f2-4218-b727-1b0ad40a73d6.webp	Sathy athani mine rode vaniputhur\n\n	Bus stop vaniputhur	11.5066104	77.3611273	6374244490					17711550000034045	KVBL0001771	Anbu raj	APPROVED	\N	0.000000000000000000000000000000	5	t	\N	0	0	2026-09-10 14:31:10.624	SYSTEM_AUTO_APPROVE	2026-09-10 14:31:10.625	2026-10-01 18:48:32.604	cmtns0y7d003qc6dkrd484hm1	cmtvlfvrl0016c68ctku1w5rk	\N	\N	\N
cmto17ygq000dc6qn4qn40mgu	cmto12z7k0001c6qnenvc4c87	Jeen@gmail.com	$2a$10$gMxXP.rrUbqJQm4SDTbEJuakWwHlKnDmig/JeCCnRvnWyvlom4Y..	Jeenora	VND-WPPU	jeenora	Perundurai,\nErode\n	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/logos/6b360966-f0b6-4425-ac6f-3564a2b5defd.webp		Perundurai \nErode\n	\N	11.2751903	77.5798711	9344193569					102901000017335	IOBA0001029	Jeena	APPROVED	\N	0.000000000000000000000000000000	5	t	\N	0	0	2026-09-05 06:58:56.954	SYSTEM_AUTO_APPROVE	2026-09-05 06:58:56.955	2026-10-01 18:48:32.609	cmtns0y7d003qc6dkrd484hm1	cmtmmk473001yc6dk3hc8mcv2	\N	\N	\N
cmto12z7q0003c6qngfgz5u4c	cmto12z7k0001c6qnenvc4c87		$2a$10$k6AoDMHi4s2osVzofio23OxGNDF8UGd3aCQB0HqaEM3SpZIoGTxl6	Sai Mowmi	VND-LXVF	madhu-forming	We delivered more expensive products\n\n	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/logos/98dbb648-4651-494e-8e88-5faa92d5585b.webp		Nerinjpettai \nMettur Bhavani Main Road \nErode	\N	11.275082	77.579908	9025255639					10290100017335	IOBA0001029	Madhu	APPROVED	\N	0.000000000000000000000000000000	5	t	\N	0	0	2026-09-05 06:55:04.645	cmtlr19vc0000c695n8dulqfn	2026-09-05 06:55:04.646	2026-10-01 18:48:32.611	cmtns0y7d003qc6dkrd484hm1	cmtnu3xt8003tc6dkmpc9rycj	\N	\N	\N
cmuo0mf4b0006c6i7c9wnekd9	cmunrox3v004mc6uvcbaqmj8f	pavi.ravicm@gmail.com	$2a$10$9ay3aObC9l9smqi54qlO3e8GyLIGWTpj8evByVF/kv5ngXHZ4G98W	JYOSUKI 	VND-AWWT	jyosuki-		https://api.alltimemarket.in/uploads/all-time-market/districtmart-vendors/f66b79af-9dab-4a85-98c8-f681ae75d80e.webp	https://api.alltimemarket.in/uploads/all-time-market/districtmart-vendors/b9429b3b-36e4-4cfe-8449-e6e362f99dc6.webp	Tn palayam gobichettipalayam erode 638506	\N	\N	\N	7200473403					068301000022385	Ioba000683		APPROVED	\N	0.000000000000000000000000000000	5	t	\N	0	0	2026-09-30 11:21:54.442	cmtlr19vc0000c695n8dulqfn	2026-09-30 11:21:54.443	2026-10-01 18:48:32.627	cmtns0y7d003qc6dkrd484hm1	cmuno5h2w0008c6uvkn4m9h60	\N		\N
cmuuwy3s4000vc61p9eb1py1a	cmto12z7k0001c6qnenvc4c87	boomikar3745@gmail.com	$2a$10$6yh1lD.c/9y.e49TMg5HSuq8XvHW0ElDVfXUF4k/TxH0OJw50jXvW	BOOMIKA MEHANDI 	VND-14C2	boomika-mehandi-		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/b90ac5cb-1cfb-4f17-ac68-c688051b512c.webp		194/3, Mahalakshmi Nagar, Kolappalur, Gobichettipalayam	\N	11.5031402	77.2430789	9842712478					23190100020843	FDRL0002319	Boomika	APPROVED	\N	0.000000000000000000000000000000	5	t	\N	0	0	2026-10-05 07:13:24.386	SYSTEM_AUTO_APPROVE	2026-10-05 07:13:24.388	2026-10-05 07:14:52.648	cmtns0y7d003qc6dkrd484hm1	cmuo0v8ay0009c6i7yrv0ttra	\N		\N
\.


--
-- Data for Name: VendorRequest; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."VendorRequest" (id, "customerId", status, "shopName", "ownerName", "mobileNumber", email, "shopCategory", description, "gstNumber", "fssaiNumber", "businessRegNumber", "districtId", "areaId", address, landmark, latitude, longitude, "deliveryRadius", "accountHolderName", "bankName", "accountNumber", "ifscCode", "upiId", "logoUrl", "bannerUrl", "ownerPhotoUrl", "govtIdUrl", "gstCertUrl", "fssaiCertUrl", "adminRemarks", "rejectionReason", "reviewedBy", "reviewedAt", "submittedAt", "createdAt", "updatedAt", "staffReferralCode", "staffId") FROM stdin;
cmtztsftb003hc63v40bu8dxj	cmtztni07003dc63v3wiwnag1	DRAFT	Monisha photography	Karthi	9597771524	_monisha_photography_gmail.com						\N	\N		\N	\N	\N	5												\N	\N	\N	\N	\N	2026-09-13 13:04:09.744	2026-09-13 13:04:09.744	\N	\N
cmtqyetge009bc6qnz7d9yws6	cmtqydagw0097c6qnh0nc7eqk	DRAFT	GS Centring&bar bending	Shanmugam	9976169926		Other					cmtns0y7d003qc6dkrd484hm1	\N	Indra nagar\nT.n.palayam.638506\n	\N	11.3137705	77.2434054	50	Shanmugam	State Bank of india	40707533982	SBIN0002278								\N	\N	\N	\N	\N	2026-09-07 08:03:36.734	2026-09-07 08:11:33.229	\N	\N
cmu2qctsj0016c644rln4ap63	cmtob892m003xc6qnqhmxp8lu	DRAFT	Karthi I	Karthik 	9840533138	karthikk96893@gmail.com						\N	\N		\N	\N	\N	5												\N	\N	\N	\N	\N	2026-09-15 13:51:21.043	2026-09-15 13:51:21.043	\N	\N
cmto14048000bc6qnudsyo4nw	cmtmmk473001yc6dk3hc8mcv2	APPROVED	Jeenora	Jeena	9344193569	Jeen@gmail.com	Other	Perundurai,\nErode\n				\N	\N	Perundurai \nErode\n	\N	11.2751903	77.5798711	5	Jeena	Iob	102901000017335	IOBA0001029		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/1b030977-463d-4d6e-a976-c226b621cb36.webp						\N	\N	SYSTEM_AUTO_APPROVE	2026-09-05 06:58:56.956	2026-09-05 06:58:56.858	2026-09-05 06:55:52.473	2026-10-01 18:51:10.015	\N	\N
cmtvlj1z7001bc68cbi3qqc1z	cmtvlfvrl0016c68ctku1w5rk	APPROVED	Auto sarvies	Anburaj	6374244490	anbur8239@gmail.com	Other					cmtns0y7d003qc6dkrd484hm1	\N	Sathy athani mine rode vaniputhur\n\n	Bus stop vaniputhur	11.5066104	77.3611273	5	Anbu raj	KVB	17711550000034045	KVBL0001771		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/4738974e-d0c9-4852-8725-55c78422b66a.webp	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/f6ba2ff9-84f2-4218-b727-1b0ad40a73d6.webp	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/b59fff47-468c-45f3-afd2-53705f4826b0.webp				\N	\N	SYSTEM_AUTO_APPROVE	2026-09-10 14:31:10.629	2026-09-10 14:31:10.505	2026-09-10 14:01:50.275	2026-10-01 18:51:10.019	\N	\N
cmtwztihc000oc68mlyohaioe	cmtwzsg5a000kc68mg01auon4	APPROVED	Iniyal boutique	Soniya S	9344938459	soniyashanmugam1725@gmail.com	Other	Dress sales and stitching				\N	\N	287, indhara nagar, kowndampalayam,\nT. N. Palayam(po),\nGobi(TK),\nErode(DT),\nPincode 638506	Manoj Petrol bunk	11.5079459	77.3803523	5	Soniya	State Bank of india 	33335032494	SBIN0002278		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/567027dc-20d2-4843-8069-b1d4f4e0cce6.webp		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/b639cd8a-5bce-4b23-9ba1-05d321494c51.webp	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/026a073e-fe4b-49e1-a35b-e5b1da9cbb00.webp			\N	\N	SYSTEM_AUTO_APPROVE	2026-09-11 13:35:14.155	2026-09-11 13:35:13.974	2026-09-11 13:29:39.024	2026-10-01 18:51:10.021	\N	\N
cmto069fi004gc6dkf1p4akoh	cmtnu3xt8003tc6dkmpc9rycj	APPROVED	Madhu Forming	Madhumadhi	9025255639		Fruits & Vegetables	We delivered more expensive products\n\n				\N	\N	Perunduria ,\nErode	\N	11.275082	77.579908	5	Madhu	Ion	10290100017335	IOBA0001029		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/8f815bf5-9c46-4764-b69f-4e9dbfd04282.webp						\N	\N	cmtlr19vc0000c695n8dulqfn	2026-09-05 06:55:04.658	2026-09-05 06:48:46.656	2026-09-05 06:29:38.238	2026-10-01 18:51:10.023	\N	\N
cmtq1aes9007gc6qn509l34g3	cmtq18z7d007cc6qnwch0now5	APPROVED	THIGAZHL NALANGU MAAVU	Chandrika	9944932484	Mothigazhl@gmail.com	Organic & Natural	Organic products 				\N	\N	Maint.road\nVaniputhur.638506	\N	11.5066044	77.3616894	50	Chandrika	Tamilnadu grama bank	000087601068	IDIB0PLB001		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/aa1dd102-f917-4ffc-be85-0312012c23cf.webp						\N	\N	SYSTEM_AUTO_APPROVE	2026-09-06 16:57:55.006	2026-09-06 16:57:54.887	2026-09-06 16:36:23.769	2026-10-01 18:51:10.025	\N	\N
cmu01582l003oc63v0ldx5g5q	cmu01265v003kc63vin8jkqo4	APPROVED	Pet shop	Surya	9788828179	Sabarisuryaprakash@gmail.com	Pet Supplies					\N	\N	16/6,kamarajar street,\nT. N. Palayam 	Anna silai	11.5037578	77.3870987	5	Suryaprakash L	State bank of india	32965602773	SBIN0002278		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/72dd413c-fc32-4852-b7de-38e498a4ae48.webp	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/a804a8f4-0700-4136-9a2b-80d4946bac44.webp	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/e8a35219-a251-45b8-8439-7c9427ccb911.webp				\N	\N	SYSTEM_AUTO_APPROVE	2026-09-13 16:35:53.627	2026-09-13 16:35:53.508	2026-09-13 16:30:03.549	2026-10-01 18:51:10.026	\N	\N
cmu28q8om000zc644r1atx5pz	cmu28pbx5000vc644mn66ku0x	DRAFT	11:11 makeover & academy 	Lavanyaa Mariyappan 	9643311407		Other					\N	\N	\nSai Tower, 5, opp. to Rama Metal Mart, Gobichettipalayam, Tamil Nadu 638452	\N	11.4558527	77.4359135	50	Lavanyaa Mariyappan 	Yes bank	120861900000730	YESB0001208		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/928a1954-2cc7-4d7b-bdcc-2e06551d45a9.webp		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/f218c593-0fc7-451a-96b2-842d44968252.webp				\N	\N	\N	\N	\N	2026-09-15 05:37:53.782	2026-10-01 18:51:10.027	\N	\N
cmunpbkwr0012c6uv63ql5c7r	cmuno5h2w0008c6uvkn4m9h60	APPROVED	JYOSUKI 	Pallavi Ravichandran	7200473403	pavi.ravicm@gmail.com	Baby & Kids	Sarees and Kids dress \n\n				cmtns0y7d003qc6dkrd484hm1	cmunrox3v004mc6uvcbaqmj8f	Tn palayam gobichettipalayam erode 638506	\N	11.5101921	77.3839403	5												\N	\N	cmtlr19vc0000c695n8dulqfn	2026-09-30 11:21:54.451	2026-09-30 11:21:54.451	2026-09-30 06:05:32.955	2026-09-30 11:21:54.452	\N	\N
cmuo1p3w7000nc6i7d0ftxm7m	cmuntrw5o0000c683ml9jqd1l	APPROVED	testing shop	\N	6381027847	shop@gmail.com	\N	\N	\N	\N	\N	cmtns0y7d003qc6dkrd484hm1	cmunrot04002sc6uvwi03p8sk	Harur	\N	\N	\N	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cmtlr19vc0000c695n8dulqfn	2026-09-30 08:10:12.583	2026-09-30 08:10:12.584	2026-09-30 11:51:59.479	2026-09-30 11:51:59.479	\N	\N
cmtmrmc8a002bc6dkw924shd7	cmtmrl33p0027c6dknt5h6xfq	APPROVED	ZHI DIMENSIONS 	Srinivasan	9865930083	Zhidimensions@gmail.com	Other	Steel products 				\N	\N	76,sathy-athani mainroad\nVaniputhur 638506\n	Mainroad	11.5050733	77.3602967	50	Srinivasan 	Fedaral	23220200002050	FDRL0002322		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/48073c34-be36-4a26-8c9b-639cd43ca46d.webp	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/b0e2f8da-c0ad-4ee8-bfd3-4418fd3b18f4.webp					\N	\N	SYSTEM_AUTO_APPROVE	2026-09-05 09:26:29.479	2026-09-05 09:26:29.369	2026-09-04 09:42:25.642	2026-10-01 18:51:10.012	\N	\N
cmutexr6o0006c61p7ravzeu4	cmutexr3e0001c61p5lwz160m	APPROVED	A to Z Service 	\N	7373479123	mothilora@gmail.com	\N	\N	\N	\N	\N	cmtns0y7d003qc6dkrd484hm1	cmunrox3v004mc6uvcbaqmj8f	Tn palayam 	\N	\N	\N	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cmtlr19vc0000c695n8dulqfn	2026-10-04 06:01:28.8	2026-10-04 06:01:28.8	2026-10-04 06:01:28.8	2026-10-04 06:01:28.8	Ravichandran Muthusamy 	\N
cmuuu4cf2000lc61pc78qxy9q	cmuuu2gxe000hc61pkrbihfzc	DRAFT	BHARATHAM TRADERS 	Ashok Kumar 	9791280137		Other	Water & Wooden plate 				\N	\N	Vaikkala street Tn palayam Erode	\N	11.5064081	77.3840682	50	S Ashokkumar 	Federal Bank 	99980102213613	FDRL0002322		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/1eb1c6d9-a33a-4595-8928-aedcfbe8a6fb.webp	https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/268e264f-e7cd-49ff-a57f-f5076b5bbc55.webp					\N	\N	\N	\N	\N	2026-10-05 05:54:16.67	2026-10-05 06:00:44.713	\N	\N
cmuuwmi2i000tc61pkz8sicji	cmuo0v8ay0009c6i7yrv0ttra	APPROVED	BOOMIKA MEHANDI 	Boomika	9842712478	boomikar3745@gmail.com	Personal Care					cmtns0y7d003qc6dkrd484hm1	\N	194/3, Mahalakshmi Nagar, Kolappalur 	\N	11.5031402	77.2430789	5	Boomika	FEDERAL BANK 	23190100020843	FDRL0002319		https://api.alltimemarket.in/uploads/all-time-market/districtmart/vendors/b90ac5cb-1cfb-4f17-ac68-c688051b512c.webp						\N	\N	SYSTEM_AUTO_APPROVE	2026-10-05 07:13:24.392	2026-10-05 07:13:24.276	2026-10-05 07:04:23.035	2026-10-05 07:13:24.392	\N	\N
cmuvit97h0001c6l3up0sctdi	cmuv886sy002yc61ph3wajcek	DRAFT	SMSAD collection 	Sindhu	9790152538	sindhusurya682@gmail.com						\N	\N		\N	\N	\N	5												\N	\N	\N	\N	\N	2026-10-05 17:25:29.694	2026-10-05 17:25:29.694	\N	\N
\.


--
-- Data for Name: VendorSettlement; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."VendorSettlement" (id, "vendorId", "settlementNo", "periodStart", "periodEnd", "totalOrders", "grossAmount", "commissionAmount", "gstAmount", "platformFee", "netAmount", status, "bankReference", "rejectionReason", "approvedBy", "approvedAt", "paidAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: VendorStaff; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."VendorStaff" (id, "vendorId", email, "passwordHash", name, "isActive", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: VendorWallet; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."VendorWallet" (id, "vendorId", balance, "totalEarned", "updatedAt") FROM stdin;
\.


--
-- Data for Name: VendorWalletTransaction; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."VendorWalletTransaction" (id, "vendorId", "settlementId", type, amount, "balanceAfter", description, reference, "createdAt") FROM stdin;
\.


--
-- Data for Name: Wallet; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Wallet" (id, "customerId", balance, "updatedAt") FROM stdin;
cmtmmk475001zc6dkizxlhcsn	cmtmmk473001yc6dk3hc8mcv2	0.000000000000000000000000000000	2026-09-04 07:20:43.839
cmtmoclyv0023c6dka5zurhwq	cmtmoclyv0022c6dkyi415t8r	0.000000000000000000000000000000	2026-09-04 08:10:52.855
cmtmrl33p0028c6dk9n2s9u3b	cmtmrl33p0027c6dknt5h6xfq	0.000000000000000000000000000000	2026-09-04 09:41:27.158
cmtnu3xt8003uc6dkemgu8i28	cmtnu3xt8003tc6dkmpc9rycj	0.000000000000000000000000000000	2026-09-05 03:39:52.172
cmtob892n003yc6qn84mpy4uq	cmtob892m003xc6qnqhmxp8lu	0.000000000000000000000000000000	2026-09-05 11:39:06.863
cmtoieuv3006bc6qnkezwiob5	cmtoieuv2006ac6qnr401s5nu	0.000000000000000000000000000000	2026-09-05 15:00:12.351
cmtpdn15e0070c6qn23k12mq6	cmtpdn15d006zc6qn5ywssend	0.000000000000000000000000000000	2026-09-06 05:34:21.841
cmtq13ewi0079c6qnu8n8ir5j	cmtq13ewh0078c6qnv0cluhfe	0.000000000000000000000000000000	2026-09-06 16:30:57.329
cmtq18z7d007dc6qnpfq4v5ml	cmtq18z7d007cc6qnwch0now5	0.000000000000000000000000000000	2026-09-06 16:35:16.922
cmtqxh2y5008jc6qnw8wplzni	cmtqxh2y4008ic6qngsyygee0	0.000000000000000000000000000000	2026-09-07 07:37:22.733
cmtqydagw0098c6qnm2tdz5g7	cmtqydagw0097c6qnh0nc7eqk	0.000000000000000000000000000000	2026-09-07 08:02:25.473
cmtvlfvrl0017c68chn3szts9	cmtvlfvrl0016c68ctku1w5rk	0.000000000000000000000000000000	2026-09-10 13:59:22.257
cmtwwv0pe000ic68mrwghj2ii	cmtwwv0pe000hc68mbz6pyu1g	0.000000000000000000000000000000	2026-09-11 12:06:50.45
cmtwzsg5b000lc68md98nbonl	cmtwzsg5a000kc68mg01auon4	0.000000000000000000000000000000	2026-09-11 13:28:49.343
cmtx2lp6i0003c63vdwtnhaxj	cmtx2lp6i0002c63v8xu2kvn8	0.000000000000000000000000000000	2026-09-11 14:47:33.307
cmtyk8ja2002hc63vc20bxoj6	cmtyk8ja2002gc63vyvx2sds3	0.000000000000000000000000000000	2026-09-12 15:48:58.394
cmtztni08003ec63vndywfy2t	cmtztni07003dc63v3wiwnag1	0.000000000000000000000000000000	2026-09-13 13:00:19.303
cmu01265v003lc63vrzsd03iy	cmu01265v003kc63vin8jkqo4	0.000000000000000000000000000000	2026-09-13 16:27:41.108
cmu0qc0po0041c63vxhshprk7	cmu0qc0pn0040c63vqxsyqfw0	0.000000000000000000000000000000	2026-09-14 04:15:11.004
cmu12488q0047c63vq0i8v4ki	cmu12488q0046c63vfoalw0vq	0.000000000000000000000000000000	2026-09-14 09:45:02.906
cmu26ie5b000lc6444x8c43jk	cmu26ie5b000kc644sbz5snin	0.000000000000000000000000000000	2026-09-15 04:35:48.383
cmu28je6x000oc644oh59gmx7	cmu28je6x000nc6449oc5f25j	0.000000000000000000000000000000	2026-09-15 05:32:34.33
cmu28pbx5000wc644lcmzu3lo	cmu28pbx5000vc644mn66ku0x	0.000000000000000000000000000000	2026-09-15 05:37:11.321
cmu5s6rnq001ec6443fhvavf0	cmu5s6rnq001dc644odckzmfj	0.000000000000000000000000000000	2026-09-17 17:05:56.101
cmu6chg82001wc6443o1qu245	cmu6chg81001vc644q7a5i134	0.000000000000000000000000000000	2026-09-18 02:34:06.818
cmu6ckauf002ac644nzkq06i0	cmu6ckauf0029c6445fzyiihf	0.000000000000000000000000000000	2026-09-18 02:36:19.815
cmu6l1usv003cc644xzxqfpm7	cmu6l1usu003bc644v5ncw3gn	0.000000000000000000000000000000	2026-09-18 06:33:55.758
cmu6qngms003hc644qkxeeyfv	cmu6qngms003gc644qucmszcs	0.000000000000000000000000000000	2026-09-18 09:10:41.908
cmu73iqmh000gc6u6oj9z4n3t	cmu73iqmh000fc6u6xx8ozhtp	0.000000000000000000000000000000	2026-09-18 15:10:56.585
cmu85r14h0010c6u6d0ewa4y6	cmu85r14h000zc6u63edpsf03	0.000000000000000000000000000000	2026-09-19 09:01:08.849
cmu9r5vv80015c6u6qxr62jgc	cmu9r5vv80014c6u68omb5oda	0.000000000000000000000000000000	2026-09-20 11:48:19.988
cmumu0yrj0003c6uv7qb9w1ud	cmumu0yrj0002c6uvxrwj02fv	0.000000000000000000000000000000	2026-09-29 15:29:29.599
cmuno5h2x0009c6uvf8077nqq	cmuno5h2w0008c6uvkn4m9h60	0.000000000000000000000000000000	2026-09-30 05:32:48.441
cmunpkdvh0016c6uvemouxzvu	cmunpkdvh0015c6uv8z2uqouz	0.000000000000000000000000000000	2026-09-30 06:12:23.742
cmunrdko30021c6uveorq0cpe	cmunrdko30020c6uvldpb1kt8	0.000000000000000000000000000000	2026-09-30 07:03:05.188
cmunreekn0028c6uvcfymyelh	cmunreekn0027c6uvcq517li0	0.000000000000000000000000000000	2026-09-30 07:03:43.944
cmuntrw5o0001c683eax67kyu	cmuntrw5o0000c683ml9jqd1l	0.000000000000000000000000000000	2026-09-30 08:10:12.493
cmuo0v8ay000ac6i7aj45ig4t	cmuo0v8ay0009c6i7yrv0ttra	0.000000000000000000000000000000	2026-09-30 11:28:45.514
cmupba85d0013c6i7x9s8d2p1	cmupba85c0012c6i771dg695z	0.000000000000000000000000000000	2026-10-01 09:08:07.489
cmuqtocio001qc69bmdbv55ib	cmuqtocio001pc69bwhbjrq90	0.000000000000000000000000000000	2026-10-02 10:30:45.6
cmus31ter0034c69b256stl26	cmus31ter0033c69bpbuxoqnk	0.000000000000000000000000000000	2026-10-03 07:40:56.739
cmus7nzrl0038c69bt3ofxi6f	cmus7nzrl0037c69bs79ds5fc	0.000000000000000000000000000000	2026-10-03 09:50:09.874
cmuscskmq003cc69ba5uqr40w	cmuscskmq003bc69b9uy2g9u3	0.000000000000000000000000000000	2026-10-03 12:13:41.618
cmutexr3f0002c61p1brd8o7o	cmutexr3e0001c61p5lwz160m	0.000000000000000000000000000000	2026-10-04 06:01:28.683
cmuuu2gxe000ic61puqwuznes	cmuuu2gxe000hc61pkrbihfzc	0.000000000000000000000000000000	2026-10-05 05:52:49.202
cmuv6h7z5001sc61pxnps0m8a	cmuv6h7z4001rc61p12b47c8x	0.000000000000000000000000000000	2026-10-05 11:40:12.832
cmuv886sy002zc61pya2nk2a6	cmuv886sy002yc61ph3wajcek	0.000000000000000000000000000000	2026-10-05 12:29:10.643
cmuv8nppz0035c61p9khd9yr2	cmuv8nppz0034c61p4xexy2vq	0.000000000000000000000000000000	2026-10-05 12:41:14.999
cmv0fpc4v0006c69xxh9zs0c3	cmv0fpc4u0005c69xkz6p337x	0.000000000000000000000000000000	2026-10-09 03:57:18.895
cmv0fqywk000cc69xjupdod0a	cmv0fqywk000bc69xd760sie9	0.000000000000000000000000000000	2026-10-09 03:58:35.06
\.


--
-- Data for Name: WalletTransaction; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."WalletTransaction" (id, "walletId", type, amount, description, reference, "createdAt") FROM stdin;
\.


--
-- Data for Name: Wishlist; Type: TABLE DATA; Schema: public; Owner: groceries
--

COPY public."Wishlist" (id, "customerId", "productId", "createdAt") FROM stdin;
cmtqxu7tk0096c6qnmfxr0uph	cmtqxh2y4008ic6qngsyygee0	cmtoazvz30029c6qnpt1yvwxl	2026-09-07 07:47:35.576
\.


--
-- Name: Address Address_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_pkey" PRIMARY KEY (id);


--
-- Name: AppSetting AppSetting_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."AppSetting"
    ADD CONSTRAINT "AppSetting_pkey" PRIMARY KEY (id);


--
-- Name: Area Area_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Area"
    ADD CONSTRAINT "Area_pkey" PRIMARY KEY (id);


--
-- Name: AuditLog AuditLog_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."AuditLog"
    ADD CONSTRAINT "AuditLog_pkey" PRIMARY KEY (id);


--
-- Name: Banner Banner_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Banner"
    ADD CONSTRAINT "Banner_pkey" PRIMARY KEY (id);


--
-- Name: CartItem CartItem_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_pkey" PRIMARY KEY (id);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: Coupon Coupon_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Coupon"
    ADD CONSTRAINT "Coupon_pkey" PRIMARY KEY (id);


--
-- Name: CustomerCoupon CustomerCoupon_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."CustomerCoupon"
    ADD CONSTRAINT "CustomerCoupon_pkey" PRIMARY KEY (id);


--
-- Name: Customer Customer_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "Customer_pkey" PRIMARY KEY (id);


--
-- Name: DeliveryChargeRule DeliveryChargeRule_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."DeliveryChargeRule"
    ADD CONSTRAINT "DeliveryChargeRule_pkey" PRIMARY KEY (id);


--
-- Name: DeviceLocation DeviceLocation_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."DeviceLocation"
    ADD CONSTRAINT "DeviceLocation_pkey" PRIMARY KEY (id);


--
-- Name: District District_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."District"
    ADD CONSTRAINT "District_pkey" PRIMARY KEY (id);


--
-- Name: Inventory Inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Inventory"
    ADD CONSTRAINT "Inventory_pkey" PRIMARY KEY (id);


--
-- Name: MicroBanner MicroBanner_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."MicroBanner"
    ADD CONSTRAINT "MicroBanner_pkey" PRIMARY KEY (id);


--
-- Name: Notification Notification_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_pkey" PRIMARY KEY (id);


--
-- Name: Offer Offer_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Offer"
    ADD CONSTRAINT "Offer_pkey" PRIMARY KEY (id);


--
-- Name: OrderItem OrderItem_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_pkey" PRIMARY KEY (id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- Name: OtpSession OtpSession_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."OtpSession"
    ADD CONSTRAINT "OtpSession_pkey" PRIMARY KEY (id);


--
-- Name: Payment Payment_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_pkey" PRIMARY KEY (id);


--
-- Name: ProductApproval ProductApproval_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."ProductApproval"
    ADD CONSTRAINT "ProductApproval_pkey" PRIMARY KEY (id);


--
-- Name: ProductImage ProductImage_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."ProductImage"
    ADD CONSTRAINT "ProductImage_pkey" PRIMARY KEY (id);


--
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- Name: RefreshToken RefreshToken_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."RefreshToken"
    ADD CONSTRAINT "RefreshToken_pkey" PRIMARY KEY (id);


--
-- Name: Review Review_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_pkey" PRIMARY KEY (id);


--
-- Name: SearchLog SearchLog_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."SearchLog"
    ADD CONSTRAINT "SearchLog_pkey" PRIMARY KEY (id);


--
-- Name: StaffAuditLog StaffAuditLog_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."StaffAuditLog"
    ADD CONSTRAINT "StaffAuditLog_pkey" PRIMARY KEY (id);


--
-- Name: Staff Staff_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Staff"
    ADD CONSTRAINT "Staff_pkey" PRIMARY KEY (id);


--
-- Name: StaticPage StaticPage_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."StaticPage"
    ADD CONSTRAINT "StaticPage_pkey" PRIMARY KEY (id);


--
-- Name: SuperAdmin SuperAdmin_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."SuperAdmin"
    ADD CONSTRAINT "SuperAdmin_pkey" PRIMARY KEY (id);


--
-- Name: SupportTicket SupportTicket_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."SupportTicket"
    ADD CONSTRAINT "SupportTicket_pkey" PRIMARY KEY (id);


--
-- Name: VendorRequest VendorRequest_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorRequest"
    ADD CONSTRAINT "VendorRequest_pkey" PRIMARY KEY (id);


--
-- Name: VendorSettlement VendorSettlement_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorSettlement"
    ADD CONSTRAINT "VendorSettlement_pkey" PRIMARY KEY (id);


--
-- Name: VendorStaff VendorStaff_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorStaff"
    ADD CONSTRAINT "VendorStaff_pkey" PRIMARY KEY (id);


--
-- Name: VendorWalletTransaction VendorWalletTransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorWalletTransaction"
    ADD CONSTRAINT "VendorWalletTransaction_pkey" PRIMARY KEY (id);


--
-- Name: VendorWallet VendorWallet_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorWallet"
    ADD CONSTRAINT "VendorWallet_pkey" PRIMARY KEY (id);


--
-- Name: Vendor Vendor_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Vendor"
    ADD CONSTRAINT "Vendor_pkey" PRIMARY KEY (id);


--
-- Name: WalletTransaction WalletTransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."WalletTransaction"
    ADD CONSTRAINT "WalletTransaction_pkey" PRIMARY KEY (id);


--
-- Name: Wallet Wallet_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Wallet"
    ADD CONSTRAINT "Wallet_pkey" PRIMARY KEY (id);


--
-- Name: Wishlist Wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Wishlist"
    ADD CONSTRAINT "Wishlist_pkey" PRIMARY KEY (id);


--
-- Name: Address_customerId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Address_customerId_idx" ON public."Address" USING btree ("customerId");


--
-- Name: AppSetting_key_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "AppSetting_key_key" ON public."AppSetting" USING btree (key);


--
-- Name: Area_districtId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Area_districtId_idx" ON public."Area" USING btree ("districtId");


--
-- Name: AuditLog_action_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "AuditLog_action_idx" ON public."AuditLog" USING btree (action);


--
-- Name: AuditLog_actorId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "AuditLog_actorId_idx" ON public."AuditLog" USING btree ("actorId");


--
-- Name: AuditLog_createdAt_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "AuditLog_createdAt_idx" ON public."AuditLog" USING btree ("createdAt");


--
-- Name: AuditLog_entityType_entityId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "AuditLog_entityType_entityId_idx" ON public."AuditLog" USING btree ("entityType", "entityId");


--
-- Name: Banner_districtId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Banner_districtId_idx" ON public."Banner" USING btree ("districtId");


--
-- Name: CartItem_customerId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "CartItem_customerId_idx" ON public."CartItem" USING btree ("customerId");


--
-- Name: CartItem_customerId_productId_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "CartItem_customerId_productId_key" ON public."CartItem" USING btree ("customerId", "productId");


--
-- Name: CartItem_vendorId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "CartItem_vendorId_idx" ON public."CartItem" USING btree ("vendorId");


--
-- Name: Category_slug_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Category_slug_key" ON public."Category" USING btree (slug);


--
-- Name: Coupon_code_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Coupon_code_key" ON public."Coupon" USING btree (code);


--
-- Name: CustomerCoupon_customerId_couponId_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "CustomerCoupon_customerId_couponId_key" ON public."CustomerCoupon" USING btree ("customerId", "couponId");


--
-- Name: Customer_email_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Customer_email_key" ON public."Customer" USING btree (email);


--
-- Name: Customer_phone_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Customer_phone_key" ON public."Customer" USING btree (phone);


--
-- Name: Customer_staffId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Customer_staffId_idx" ON public."Customer" USING btree ("staffId");


--
-- Name: DeliveryChargeRule_districtId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "DeliveryChargeRule_districtId_idx" ON public."DeliveryChargeRule" USING btree ("districtId");


--
-- Name: DeviceLocation_customerId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "DeviceLocation_customerId_idx" ON public."DeviceLocation" USING btree ("customerId");


--
-- Name: DeviceLocation_deviceId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "DeviceLocation_deviceId_idx" ON public."DeviceLocation" USING btree ("deviceId");


--
-- Name: DeviceLocation_deviceId_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "DeviceLocation_deviceId_key" ON public."DeviceLocation" USING btree ("deviceId");


--
-- Name: District_code_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "District_code_key" ON public."District" USING btree (code);


--
-- Name: Inventory_productId_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Inventory_productId_key" ON public."Inventory" USING btree ("productId");


--
-- Name: MicroBanner_districtId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "MicroBanner_districtId_idx" ON public."MicroBanner" USING btree ("districtId");


--
-- Name: Notification_customerId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Notification_customerId_idx" ON public."Notification" USING btree ("customerId");


--
-- Name: Notification_vendorId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Notification_vendorId_idx" ON public."Notification" USING btree ("vendorId");


--
-- Name: OrderItem_orderId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "OrderItem_orderId_idx" ON public."OrderItem" USING btree ("orderId");


--
-- Name: Order_createdAt_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Order_createdAt_idx" ON public."Order" USING btree ("createdAt");


--
-- Name: Order_customerId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Order_customerId_idx" ON public."Order" USING btree ("customerId");


--
-- Name: Order_orderNumber_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Order_orderNumber_key" ON public."Order" USING btree ("orderNumber");


--
-- Name: Order_settlementId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Order_settlementId_idx" ON public."Order" USING btree ("settlementId");


--
-- Name: Order_status_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Order_status_idx" ON public."Order" USING btree (status);


--
-- Name: Order_vendorId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Order_vendorId_idx" ON public."Order" USING btree ("vendorId");


--
-- Name: OtpSession_phone_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "OtpSession_phone_idx" ON public."OtpSession" USING btree (phone);


--
-- Name: Payment_customerId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Payment_customerId_idx" ON public."Payment" USING btree ("customerId");


--
-- Name: Payment_reference_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Payment_reference_key" ON public."Payment" USING btree (reference);


--
-- Name: ProductApproval_productId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "ProductApproval_productId_idx" ON public."ProductApproval" USING btree ("productId");


--
-- Name: ProductApproval_status_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "ProductApproval_status_idx" ON public."ProductApproval" USING btree (status);


--
-- Name: ProductApproval_vendorId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "ProductApproval_vendorId_idx" ON public."ProductApproval" USING btree ("vendorId");


--
-- Name: ProductImage_productId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "ProductImage_productId_idx" ON public."ProductImage" USING btree ("productId");


--
-- Name: Product_categoryId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Product_categoryId_idx" ON public."Product" USING btree ("categoryId");


--
-- Name: Product_sku_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Product_sku_idx" ON public."Product" USING btree (sku);


--
-- Name: Product_status_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Product_status_idx" ON public."Product" USING btree (status);


--
-- Name: Product_vendorId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Product_vendorId_idx" ON public."Product" USING btree ("vendorId");


--
-- Name: Product_vendorId_slug_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Product_vendorId_slug_key" ON public."Product" USING btree ("vendorId", slug);


--
-- Name: Product_vendorId_status_isActive_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Product_vendorId_status_isActive_idx" ON public."Product" USING btree ("vendorId", status, "isActive");


--
-- Name: RefreshToken_token_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "RefreshToken_token_key" ON public."RefreshToken" USING btree (token);


--
-- Name: RefreshToken_userId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "RefreshToken_userId_idx" ON public."RefreshToken" USING btree ("userId");


--
-- Name: Review_customerId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Review_customerId_idx" ON public."Review" USING btree ("customerId");


--
-- Name: Review_productId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Review_productId_idx" ON public."Review" USING btree ("productId");


--
-- Name: Review_vendorId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Review_vendorId_idx" ON public."Review" USING btree ("vendorId");


--
-- Name: SearchLog_query_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "SearchLog_query_idx" ON public."SearchLog" USING btree (query);


--
-- Name: StaffAuditLog_action_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "StaffAuditLog_action_idx" ON public."StaffAuditLog" USING btree (action);


--
-- Name: StaffAuditLog_createdAt_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "StaffAuditLog_createdAt_idx" ON public."StaffAuditLog" USING btree ("createdAt");


--
-- Name: StaffAuditLog_staffId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "StaffAuditLog_staffId_idx" ON public."StaffAuditLog" USING btree ("staffId");


--
-- Name: Staff_areaId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Staff_areaId_idx" ON public."Staff" USING btree ("areaId");


--
-- Name: Staff_code_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Staff_code_idx" ON public."Staff" USING btree (code);


--
-- Name: Staff_code_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Staff_code_key" ON public."Staff" USING btree (code);


--
-- Name: Staff_districtId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Staff_districtId_idx" ON public."Staff" USING btree ("districtId");


--
-- Name: Staff_phone_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Staff_phone_key" ON public."Staff" USING btree (phone);


--
-- Name: StaticPage_slug_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "StaticPage_slug_key" ON public."StaticPage" USING btree (slug);


--
-- Name: SuperAdmin_email_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "SuperAdmin_email_key" ON public."SuperAdmin" USING btree (email);


--
-- Name: SupportTicket_customerId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "SupportTicket_customerId_idx" ON public."SupportTicket" USING btree ("customerId");


--
-- Name: VendorRequest_customerId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "VendorRequest_customerId_idx" ON public."VendorRequest" USING btree ("customerId");


--
-- Name: VendorRequest_staffId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "VendorRequest_staffId_idx" ON public."VendorRequest" USING btree ("staffId");


--
-- Name: VendorRequest_status_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "VendorRequest_status_idx" ON public."VendorRequest" USING btree (status);


--
-- Name: VendorSettlement_createdAt_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "VendorSettlement_createdAt_idx" ON public."VendorSettlement" USING btree ("createdAt");


--
-- Name: VendorSettlement_settlementNo_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "VendorSettlement_settlementNo_key" ON public."VendorSettlement" USING btree ("settlementNo");


--
-- Name: VendorSettlement_status_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "VendorSettlement_status_idx" ON public."VendorSettlement" USING btree (status);


--
-- Name: VendorSettlement_vendorId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "VendorSettlement_vendorId_idx" ON public."VendorSettlement" USING btree ("vendorId");


--
-- Name: VendorSettlement_vendorId_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "VendorSettlement_vendorId_key" ON public."VendorSettlement" USING btree ("vendorId");


--
-- Name: VendorStaff_email_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "VendorStaff_email_key" ON public."VendorStaff" USING btree (email);


--
-- Name: VendorStaff_vendorId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "VendorStaff_vendorId_idx" ON public."VendorStaff" USING btree ("vendorId");


--
-- Name: VendorWalletTransaction_createdAt_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "VendorWalletTransaction_createdAt_idx" ON public."VendorWalletTransaction" USING btree ("createdAt");


--
-- Name: VendorWalletTransaction_settlementId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "VendorWalletTransaction_settlementId_idx" ON public."VendorWalletTransaction" USING btree ("settlementId");


--
-- Name: VendorWalletTransaction_vendorId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "VendorWalletTransaction_vendorId_idx" ON public."VendorWalletTransaction" USING btree ("vendorId");


--
-- Name: VendorWallet_vendorId_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "VendorWallet_vendorId_key" ON public."VendorWallet" USING btree ("vendorId");


--
-- Name: Vendor_areaId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Vendor_areaId_idx" ON public."Vendor" USING btree ("areaId");


--
-- Name: Vendor_code_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Vendor_code_key" ON public."Vendor" USING btree (code);


--
-- Name: Vendor_customerId_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Vendor_customerId_key" ON public."Vendor" USING btree ("customerId");


--
-- Name: Vendor_districtId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Vendor_districtId_idx" ON public."Vendor" USING btree ("districtId");


--
-- Name: Vendor_districtId_status_isOpen_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Vendor_districtId_status_isOpen_idx" ON public."Vendor" USING btree ("districtId", status, "isOpen");


--
-- Name: Vendor_email_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Vendor_email_key" ON public."Vendor" USING btree (email);


--
-- Name: Vendor_slug_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Vendor_slug_key" ON public."Vendor" USING btree (slug);


--
-- Name: Vendor_status_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Vendor_status_idx" ON public."Vendor" USING btree (status);


--
-- Name: WalletTransaction_walletId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "WalletTransaction_walletId_idx" ON public."WalletTransaction" USING btree ("walletId");


--
-- Name: Wallet_customerId_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Wallet_customerId_key" ON public."Wallet" USING btree ("customerId");


--
-- Name: Wishlist_customerId_idx; Type: INDEX; Schema: public; Owner: groceries
--

CREATE INDEX "Wishlist_customerId_idx" ON public."Wishlist" USING btree ("customerId");


--
-- Name: Wishlist_customerId_productId_key; Type: INDEX; Schema: public; Owner: groceries
--

CREATE UNIQUE INDEX "Wishlist_customerId_productId_key" ON public."Wishlist" USING btree ("customerId", "productId");


--
-- Name: Address Address_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Area Area_districtId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Area"
    ADD CONSTRAINT "Area_districtId_fkey" FOREIGN KEY ("districtId") REFERENCES public."District"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Banner Banner_districtId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Banner"
    ADD CONSTRAINT "Banner_districtId_fkey" FOREIGN KEY ("districtId") REFERENCES public."District"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CartItem CartItem_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CartItem CartItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CartItem CartItem_vendorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES public."Vendor"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Category Category_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Coupon Coupon_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Coupon"
    ADD CONSTRAINT "Coupon_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Coupon Coupon_vendorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Coupon"
    ADD CONSTRAINT "Coupon_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES public."Vendor"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CustomerCoupon CustomerCoupon_couponId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."CustomerCoupon"
    ADD CONSTRAINT "CustomerCoupon_couponId_fkey" FOREIGN KEY ("couponId") REFERENCES public."Coupon"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CustomerCoupon CustomerCoupon_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."CustomerCoupon"
    ADD CONSTRAINT "CustomerCoupon_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Customer Customer_staffId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "Customer_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."Staff"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DeliveryChargeRule DeliveryChargeRule_districtId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."DeliveryChargeRule"
    ADD CONSTRAINT "DeliveryChargeRule_districtId_fkey" FOREIGN KEY ("districtId") REFERENCES public."District"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DeviceLocation DeviceLocation_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."DeviceLocation"
    ADD CONSTRAINT "DeviceLocation_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Inventory Inventory_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Inventory"
    ADD CONSTRAINT "Inventory_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: MicroBanner MicroBanner_districtId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."MicroBanner"
    ADD CONSTRAINT "MicroBanner_districtId_fkey" FOREIGN KEY ("districtId") REFERENCES public."District"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Notification Notification_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notification Notification_vendorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES public."Vendor"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Offer Offer_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Offer"
    ADD CONSTRAINT "Offer_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Offer Offer_districtId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Offer"
    ADD CONSTRAINT "Offer_districtId_fkey" FOREIGN KEY ("districtId") REFERENCES public."District"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Offer Offer_vendorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Offer"
    ADD CONSTRAINT "Offer_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES public."Vendor"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: OrderItem OrderItem_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OrderItem OrderItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Order Order_addressId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES public."Address"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Order Order_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Order Order_paymentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES public."Payment"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Order Order_settlementId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_settlementId_fkey" FOREIGN KEY ("settlementId") REFERENCES public."VendorSettlement"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Order Order_vendorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES public."Vendor"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Payment Payment_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ProductApproval ProductApproval_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."ProductApproval"
    ADD CONSTRAINT "ProductApproval_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductImage ProductImage_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."ProductImage"
    ADD CONSTRAINT "ProductImage_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Product Product_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Product Product_subCategoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_subCategoryId_fkey" FOREIGN KEY ("subCategoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Product Product_vendorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES public."Vendor"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Review Review_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Review Review_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Review Review_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Review Review_vendorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES public."Vendor"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SearchLog SearchLog_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."SearchLog"
    ADD CONSTRAINT "SearchLog_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: StaffAuditLog StaffAuditLog_staffId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."StaffAuditLog"
    ADD CONSTRAINT "StaffAuditLog_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."Staff"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Staff Staff_areaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Staff"
    ADD CONSTRAINT "Staff_areaId_fkey" FOREIGN KEY ("areaId") REFERENCES public."Area"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Staff Staff_districtId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Staff"
    ADD CONSTRAINT "Staff_districtId_fkey" FOREIGN KEY ("districtId") REFERENCES public."District"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SupportTicket SupportTicket_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."SupportTicket"
    ADD CONSTRAINT "SupportTicket_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: VendorRequest VendorRequest_areaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorRequest"
    ADD CONSTRAINT "VendorRequest_areaId_fkey" FOREIGN KEY ("areaId") REFERENCES public."Area"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: VendorRequest VendorRequest_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorRequest"
    ADD CONSTRAINT "VendorRequest_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: VendorRequest VendorRequest_districtId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorRequest"
    ADD CONSTRAINT "VendorRequest_districtId_fkey" FOREIGN KEY ("districtId") REFERENCES public."District"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: VendorRequest VendorRequest_staffId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorRequest"
    ADD CONSTRAINT "VendorRequest_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."Staff"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: VendorSettlement VendorSettlement_vendorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorSettlement"
    ADD CONSTRAINT "VendorSettlement_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES public."Vendor"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: VendorStaff VendorStaff_vendorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorStaff"
    ADD CONSTRAINT "VendorStaff_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES public."Vendor"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: VendorWalletTransaction VendorWalletTransaction_settlementId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorWalletTransaction"
    ADD CONSTRAINT "VendorWalletTransaction_settlementId_fkey" FOREIGN KEY ("settlementId") REFERENCES public."VendorSettlement"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: VendorWalletTransaction VendorWalletTransaction_vendorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorWalletTransaction"
    ADD CONSTRAINT "VendorWalletTransaction_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES public."Vendor"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: VendorWallet VendorWallet_vendorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."VendorWallet"
    ADD CONSTRAINT "VendorWallet_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES public."Vendor"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Vendor Vendor_areaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Vendor"
    ADD CONSTRAINT "Vendor_areaId_fkey" FOREIGN KEY ("areaId") REFERENCES public."Area"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Vendor Vendor_districtId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Vendor"
    ADD CONSTRAINT "Vendor_districtId_fkey" FOREIGN KEY ("districtId") REFERENCES public."District"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Vendor Vendor_staffId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Vendor"
    ADD CONSTRAINT "Vendor_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."Staff"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: WalletTransaction WalletTransaction_walletId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."WalletTransaction"
    ADD CONSTRAINT "WalletTransaction_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES public."Wallet"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Wallet Wallet_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Wallet"
    ADD CONSTRAINT "Wallet_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Wishlist Wishlist_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Wishlist"
    ADD CONSTRAINT "Wishlist_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Wishlist Wishlist_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groceries
--

ALTER TABLE ONLY public."Wishlist"
    ADD CONSTRAINT "Wishlist_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO groceries;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO groceries;


--
-- PostgreSQL database dump complete
--

\unrestrict XD93F9cCr2jynjqUqdJldf4NU0dee0Qa3PaNwJ9YQ30PDIh4dAhQ8vzWEVhfmb0


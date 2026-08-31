UPDATE "VendorRequest"
SET status = 'REJECTED', "rejectionReason" = 'Vendor account was removed by admin.'
WHERE status = 'APPROVED'
AND "customerId" NOT IN (
  SELECT "customerId" FROM "Vendor" WHERE "customerId" IS NOT NULL
);

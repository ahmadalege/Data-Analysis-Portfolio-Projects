--cleaning the data
select * from "nashville housing project";


--standardizing date

update "nashville housing project" 
set "SaleDate" = "SaleDate"::date ;


--populate property address data
SELECT  "a"."ParcelID", "a"."PropertyAddress", "b"."ParcelID", "b"."PropertyAddress", COALESCE("a"."PropertyAddress", "b"."PropertyAddress")
from "nashville housing project" a
join "nashville housing project" b
on "a"."ParcelID" = "b"."ParcelID"
and "a"."UniqueID" <> "b"."UniqueID"
where "a"."PropertyAddress" is null;


UPDATE "nashville housing project"
set "PropertyAddress" =  COALESCE("a"."PropertyAddress", "b"."PropertyAddress")
from "nashville housing project" a
join "nashville housing project" b
on "a"."ParcelID" = "b"."ParcelID"
and "a"."UniqueID" <> "b"."UniqueID"
where "a"."PropertyAddress" is null;


--Breaking address into individual columns(Address, city and state )

SELECT "PropertyAddress"
from "nashville housing project";


SELECT
"PropertyAddress",
  SUBSTRING("PropertyAddress" FROM 1 FOR POSITION(',' IN "PropertyAddress") - 1) AS Address,
  SUBSTRING("PropertyAddress" FROM POSITION(',' IN "PropertyAddress") +1) as City 
  
FROM "nashville housing project";


alter TABLE "nashville housing project"
add "PropertySplitAddress" VARCHAR(255);

update "nashville housing project" 
set "PropertySplitAddress" = SUBSTRING("PropertyAddress" FROM 1 FOR POSITION(',' IN "PropertyAddress") - 1);


alter TABLE "nashville housing project"
add "PropertySplitCity" VARCHAR(255);

update "nashville housing project" 
set "PropertySplitCity" =   SUBSTRING("PropertyAddress" FROM POSITION(',' IN "PropertyAddress") +1) ;

select 
SPLIT_PART(REPLACE("OwnerAddress", ',', '.'), '.', 1),
SPLIT_PART(REPLACE("OwnerAddress", ',', '.'), '.', 2),
SPLIT_PART(REPLACE("OwnerAddress", ',', '.'), '.', 3) 

from "nashville housing project";
 
alter TABLE "nashville housing project"
add "OwnerSplitAddress" VARCHAR(255);

update "nashville housing project" 
set "OwnerSplitAddress" = SPLIT_PART(REPLACE("OwnerAddress", ',', '.'), '.', 1);


alter TABLE "nashville housing project"
add "OwnerSplitCity" VARCHAR(255);

update "nashville housing project" 
set "OwnerSplitCity" = SPLIT_PART(REPLACE("OwnerAddress", ',', '.'), '.', 2);


alter TABLE "nashville housing project"
add "OwnerSplitState" VARCHAR(255);

update "nashville housing project" 
set "OwnerSplitState" = SPLIT_PART(REPLACE("OwnerAddress", ',', '.'), '.', 3) ;


--Change Y and N to Yes and No in "Sold as VAcant field"
SELECT "SoldAsVacant",
case when "SoldAsVacant" = 'Y' Then 'Yes'
     when "SoldAsVacant" = 'N' then 'No'
     else "SoldAsVacant"
     end ;

from "nashville housing project"

UPDATE "nashville housing project"
set "SoldAsVacant" = case when "SoldAsVacant" = 'Y' Then 'Yes'
     when "SoldAsVacant" = 'N' then 'No'
     else "SoldAsVacant"
     end ;


--Delete Unused Columns

alter table "nashville housing project"
drop COLUMN "OwnerAddress", 
drop COLUMN "TaxDistrict",
drop COLUMN "PropertyAddress",
drop COLUMN "SaleDate"


SELECT * from "nashville housing project"



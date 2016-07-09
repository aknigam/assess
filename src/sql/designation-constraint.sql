use assess;

alter table Designation
ADD CONSTRAINT customer_designation_ukey UNIQUE (Customerid,Name)
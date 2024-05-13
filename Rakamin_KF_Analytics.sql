
SELECT 
  fintra.transaction_id, 
  fintra.date, 
  fintra.branch_id, 
  kanca.branch_name, 
  kanca.kota, 
  kanca.provinsi, 
  fintra.rating, 
  fintra.customer_name, 
  fintra.product_id, 
  prod.product_name, 
  prod.price, 
  fintra.discount_percentage,
  CASE
    WHEN prod.price <= 50000 THEN prod.price * 0.10
    WHEN prod.price > 50000 AND prod.price <= 100000 THEN prod.price * 0.15
    WHEN prod.price > 100000 AND prod.price <= 300000 THEN prod.price * 0.20
    WHEN prod.price > 300000 AND prod.price <= 500000 THEN prod.price * 0.25
    WHEN prod.price > 500000 THEN prod.price * 0.3
  END AS persentase_gross_laba, 
  (prod.price - (prod.price * fintra.discount_percentage / 100)) AS nett_sales,
  ((prod.price - (prod.price * fintra.discount_percentage / 100)) * CASE
    WHEN prod.price <= 50000 then 0.1
    when prod.price > 50000 and prod.price <= 100000 then 0.15
    when prod.price > 100000 and prod.price <= 300000 then 0.2
    when prod.price > 300000 and prod.price <= 500000 then 0.25
    WHEN prod.price > 500000 THEN 0.3
  END) AS nett_profit,
  fintra.rating AS rating_transaksi
FROM `kimia_farma.kf_final_transaction` as fintra
left join `kimia_farma.kf_kantor_cabang` as kanca
on fintra.branch_id=kanca.branch_id
left join `kimia_farma.kf_product` as prod
on fintra.product_id=prod.product_id
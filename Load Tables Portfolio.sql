CREATE TABLE product_dim 
(product_id integer PRIMARY KEY,
    product_name character varying(40) NOT NULL,
	product_desc text,
	supplier_name character varying(40) NOT NULL,
	category_name character varying(15) NOT NULL,
    cat_desc text,
	discontinued character varying(1) NOT NULL CHECK (discontinued like 'Y' or discontinued like 'N')
);
CREATE TABLE customer_dim
(customer_id bpchar PRIMARY KEY,
 	company_name character varying(40) NOT NULL,
	customer_demographic text,
	address character varying(60),
    city character varying(25),
    state_abbr character varying(2),
    postal_code character varying(5),
    country character varying(15)
);
CREATE TABLE employee_dim
(employee_id integer PRIMARY KEY,
 	last_name character varying(30) NOT NULL,
    first_name character varying(20) NOT NULL,
    job_title character varying(30) NOT NULL,
	hire_date date,
	reports_to character varying(30) NOT NULL,
	territory character varying(10) NOT NULL,
	region character varying(10) NOT NULL
);
CREATE TABLE date_dim
(date_key character varying(8) PRIMARY KEY,
	date date NOT NULL,
	day_o_wk character varying(10) NOT NULL,
	week_no smallint NOT NULL CHECK (week_no between 1 and 52),
	month character varying(20) NOT NULL,
	quarter character varying(6) NOT NULL,
	year integer NOT NULL CHECK(year between 1900 and 2999),
	fiscal_pd character varying(6) NOT NULL,
	calendar_pd character varying(6) NOT NULL
);

CREATE TABLE discount_dim
(discount_key bpchar PRIMARY KEY,
	discount_desc text NOT NULL,
	active character varying(1) NOT NULL CHECK (active like 'Y' or active like 'N')
);

CREATE TABLE invoice_fact
(invoice_id integer PRIMARY KEY,
	order_id integer NOT NULL,
	order_date_key character varying(8) NOT NULL REFERENCES date_dim,
	invoice_date_key character varying(8) NOT NULL REFERENCES date_dim,
	product_id integer NOT NULL REFERENCES product_dim,
	customer_id bpchar NOT NULL REFERENCES customer_dim,
	employee_id integer NOT NULL REFERENCES employee_dim,
	quantity smallint NOT NULL CHECK (quantity>0),
	unit_price real NOT NULL CHECK (unit_price>0),
    discount real CHECK (discount<=0),
	discount_key bpchar REFERENCES discount_dim,
	extended_price real NOT NULL CHECK (extended_price>=0)
);




CREATE TABLE Admin
(
    admin_id       serial                           ,
    a_name              varchar(20)                 ,
    CONSTRAINT        admin_pk PRIMARY KEY(admin_id)
);

CREATE TABLE login
(
    username              varchar(20)                 ,
    last_login           TIMESTAMP
);




CREATE TABLE customer
(
    customer_id       serial                        ,
    pincode           varcchar(16)                  ,
    phone             varchar(16)                   ,
    shipping_address  varchar(64)           NOT NULL,
    CONSTRAINT        customer_pk PRIMARY KEY(customer_id)
);

CREATE TABLE customer_details
(
    personal_id       serial             NOT NULL ,
    email             varchar(32)                   ,
    first_name        varchar(32)                   ,
    last_name         varchar(32)           NOT NULL,
    address           varchar(64)                   ,
    city              varchar(32)                   ,
    phone             varchar(10)                   ,
    created_on        TIMESTAMP               NOT NULL,
    CONSTRAINT        customer_pk PRIMARY KEY(personal_id)
) with oids;

CREATE TABLE order1
(
    order_no         serial                        ,
    date_placed      date                  NOT NULL,
    date_shipped     date                          ,
    CONSTRAINT       order_pk PRIMARY KEY(order_no),
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)        ,
	  FOREIGN KEY(admin_id) 
	  REFERENCES customers(admin_id) 
);

CREATE TABLE order_details
(
    orderdeta_id  serial                        ,
    date_placed      date                  NOT NULL,
    date_shipped     date                          ,
    shipping         numeric(7,2)                  ,
    payment_type     varchar(16)                   ,
    PRIMARY KEY(orderdeta_id)                      ,  
    CONSTRAINT fk_product
      FOREIGN KEY(pro_id) 
	  REFERENCES product(pror_id)         
) with oids;

CREATE TABLE product
(
    pro_id           serial                         ,
    pro_info       varchar(64)           NOT NULL   ,
    cost_price        numeric(7,2)                  ,
    sell_price        numeric(7,2)                  ,
    CONSTRAINT        pr_pk PRIMARY KEY(pro_id)     ,
    FOREIGN KEY(customer_id) 
	  REFERENCES customer(customer_id)          ,
	  FOREIGN KEY(cart_no) 
	  REFERENCES cart_product(cart_no)           
);

CREATE TABLE product_details
(
    proddeta_id           serial                        ,
    description       varchar(64)           NOT NULL,
    quantity          integer               NOT NULL,
    images            blob                          ,
    offers            varchar(64)                   ,            
    discount         numeric(7,2)                  ,
    validity         DATE                           ,
    cost_price        numeric(7,2)                  ,
    sell_price        numeric(7,2)                  ,
    PRIMARY KEY(proddeta_id)                        ,
    CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)         ,
	FOREIGN KEY(admin_id) 
	  REFERENCES customers(admin_id)           
) with oids;

CREATE TABLE cart_product
(
    cart_no           serial                        ,
    no_of_products    integer                       ,
    product_id        numeric(7,2)                  ,
    Total_cost        numeric(7,2)                  ,
    cart_time         TIMESTAMP                     ,
    PRIMARY KEY(cart_no)                            ,
    CONSTRAINT fk_customer  
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)         ,
	  FOREIGN KEY(order_id) 
	  REFERENCES order1(order_id)
);

CREATE TABLE supplier
(
    supplier_id           serial                        ,
    s_name                varchar(16)                   ,
    contact_no            varchar(10)
     PRIMARY KEY(supplier_id)   ,
    CONSTRAINT fk_product
      FOREIGN KEY(pro_id) 
	  REFERENCES product(pro_id)         
);

CREATE TABLE product_supplier
(
    supplier_id           integer                       ,
    pro_id                integer
);




CREATE TABLE payment
(
    payment_id           serial                        ,
    payment_type        varchar(16)                    ,
    Amount              varchar(10)                    ,
    p_time             TIMESTAMP                       ,
    PRIMARY KEY(payment_id)                            ,
    CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)
);

CREATE TABLE feedback
(
    feed_no           serial                        ,
    response          varchar(64)                   ,
    f_time            TIMESTAMPTZ                   ,
    PRIMARY KEY(feed_no)                            ,
     CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customer(customer_id)
);



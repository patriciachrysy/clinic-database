create database clinic;

create table patients(
    id serial primary key, 
    name varchar(255), 
    date_of_birth date
);

create table medical_histories(
    id serial primary key, 
    admited_at timestamp, 
    patient_id int not null, 
    status varchar(255), 
    constraint fk_patient_id foreign key (patient_id) references patients(id)
)
create index idx_medical_histories_patient_id on medical_histories(patient_id);

create table invoices(
    id serial primary key, 
    total_amount decimal, 
    generated_at timestamp, 
    payed_at timestamp, 
    medical_history_id int unique not null, 
    constraint fk_medical_history_id foreign key (medical_history_id) references medical_histories(id)
);
create index idx_invoices_medical_history_id on invoices(medical_history_id);

create table treatments(
    id serial primary key, 
    type varchar(255), 
    name varchar(255)
);

create table medical_histories_treatments(
    id serial primary key, 
    medical_history_id int not null, 
    treatment_id int not null, 
    constraint fk_medical_history_id foreign key (medical_history_id) references medical_histories(id), 
    constraint fk_treatment_id foreign key (treatment_id) references treatments(id)
);
create index idx_medical_histories_treatments_medical_history_id on medical_histories_treatments(medical_history_id);
create index idx_medical_histories_treatments_treatment_id on medical_histories_treatments(treatment_id);

create table invoice_items(
    id serial primary key, 
    unit_price decimal, 
    quantity int, 
    total_price decimal, 
    invoice_id int not null, 
    treatment_id int not null, 
    constraint fk_invoice_id foreign key (invoice_id) references invoices(id), 
    constraint fk_treatment_id foreign key (treatment_id) references treatments(id)
);
create index idx_invoice_items_invoice_id on invoice_items(invoice_id);
create index idx_invoice_items_treatment_id on invoice_items(treatment_id);
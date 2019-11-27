set names utf8;
set foreign_key_checks=0;
drop database if exists radish;
create database radish;
use radish;

drop table if exists user_info;
create table user_info(
id int not null primary key auto_increment,
user_id varchar(16) not null unique,
password varchar(16) not null,
family_name varchar(32) not null,
first_name varchar(32) not null,
family_name_kana varchar(32) not null,
first_name_kana varchar(32) not null,
sex tinyint default 0,
email varchar(32),
status tinyint default 0,
logined tinyint not null default 0,
regist_date datetime not null,
update_date datetime
);

drop table if exists product_info;
create table product_info(
id int not null primary key auto_increment,
product_id int not null unique,
product_name varchar(100) not null unique,
product_name_kana varchar(100) not null unique,
product_description varchar(255),
category_id int not null,
price int not null,
image_file_path varchar(100) not null,
image_file_name varchar(50) not null,
release_date datetime,
release_company varchar(50),
status tinyint default 1,
regist_date datetime not null,
update_date datetime,
FOREIGN KEY (category_id)
REFERENCES m_category (category_id)
);

drop table if exists cart_info;
create table cart_info(
id int not null primary key auto_increment,
user_id varchar(16) not null,
product_id int not null,
product_count int not null,
regist_date datetime not null,
update_date datetime,
FOREIGN KEY (product_id)
REFERENCES product_info (product_id)
);

drop table if exists purchase_history_info;
create table purchase_history_info(
id int not null primary key auto_increment,
user_id varchar(16) not null,
product_id int not null,
product_count int not null,
price int not null,
destination_id int not null,
regist_date datetime not null,
update_date datetime,
FOREIGN KEY (user_id)
REFERENCES user_info (user_id),
FOREIGN KEY (product_id)
REFERENCES product_info (product_id)
);

drop table if exists destination_info;
create table destination_info(
id int not null primary key auto_increment,
user_id varchar(16) not null,
family_name varchar(32) not null,
first_name varchar(32) not null,
family_name_kana varchar(32) not null,
first_name_kana varchar(32) not null,
email varchar(32),
tel_number varchar(13),
user_address varchar(50) not null,
regist_date datetime not null,
update_date datetime,
FOREIGN KEY (user_id)
REFERENCES user_info (user_id)
);
drop table if exists m_category;
create table m_category(
id int not null primary key auto_increment,
category_id int not null unique,
category_name varchar(20) not null unique,
category_description varchar(100),
regist_date datetime not null,
update_date datetime
);

insert into user_info(user_id,password,family_name,first_name,family_name_kana,first_name_kana,status,logined,regist_date,update_date) values
("guest","guest","ゲスト","ユーザー1","げすと","ゆーざー1",1,0,now(),now()),
("guest2","guest2","ゲスト","ユーザー2","げすと","ゆーざー2",0,0,now(),now()),
("guest3","guest3","ゲスト","ユーザー3","げすと","ゆーざー3",0,0,now(),now()),
("guest4","guest4","ゲスト","ユーザー4","げすと","ゆーざー4",0,0,now(),now()),
("guest5","guest5","ゲスト","ユーザー5","げすと","ゆーざー5",0,0,now(),now()),
("guest6","guest6","ゲスト","ユーザー6","げすと","ゆーざー6",0,0,now(),now()),
("guest7","guest7","ゲスト","ユーザー7","げすと","ゆーざー7",0,0,now(),now()),
("guest8","guest8","ゲスト","ユーザー8","げすと","ゆーざー8",0,0,now(),now()),
("guest9","guest9","ゲスト","ユーザー9","げすと","ゆーざー9",0,0,now(),now()),
("guest10","guest10","ゲスト","ユーザー10","げすと","ゆーざー10",0,0,now(),now()),
("guest11","guest11","ゲスト","ユーザー11","げすと","ゆーざー11",0,0,now(),now()),
("guest12","guest12","ゲスト","ユーザー12","げすと","ゆーざー12",0,0,now(),now());

insert into m_category values
(1,1,"全てのカテゴリー","楽器、飲料、菓子類、文房具全てのカテゴリーが対象となります",now(), now()),
(2,2,"楽器","楽器に関するカテゴリーが対象となります",now(),now()),
(3,3,"飲料","飲料に関するカテゴリーが対象となります",now(),now()),
(4,4,"菓子","菓子に関するカテゴリーが対象となります",now(),now()),
(5,5,"文房具","文房具に関するカテゴリーが対象となります",now(),now());

insert into destination_info values
(1,"guest","インターノウス","テストユーザー","いんたーのうす","てすとゆーざー","guest@internous.co.jp","080-1234-5678","東京都千代田区三番町１ー１　ＫＹ三番町ビル１Ｆ",now(),now());

insert into product_info values
(1, 1,"ギター","ぎたー","6本の異なる音の出る弦を持ったいかした楽器、これを持ってるだけで彼女もできる。",2,500000,"./images","Guitar.jpg",now(),"(株)YAMADA",1,now(),now()),
(2, 2,"ピアノ","ぴあの","お馴染みダルシマーから派生して作られた楽器、奏法（或いは楽曲）によっては人々を夢の中へと導く不思議な力を持つ。",2,800000,"./images","Piano.jpg",now(),"(株)YAMADA",1,now(),now()),
(3, 3,"トランペット","とらんぺっと","遥か昔には木、竹、樹皮、粘土、人骨、金属が素材に用いられていた。戦争行進にうってつけの楽器ということでトランペットが用いられた。",2,350000,"./images","Trumpet.jpg",now(),"(株)YAMADA",1,now(),now()),
(4, 4,"ハンドパン","はんどぱん","素手でたたけるスティールパン(Hang)人気が広まった当初は製法や入手方法については謎に包まれていた。時がたちHang→ハング→ハンド→ハンドパンとなった。",2,120000,"./images","Steel Hand Pan.jpg",now(),"(株)YAMADA",1,now(),now()),
(5, 5,"パイプオルガン","ぱいぷおるがん","神に捧ぐ賛美の音、故に教会等で主に用いられる。覚悟があるなら買うと良いだろう",2,10000000,"./images","Pipe Organ.jpg",now(),"(株)YAMADA",1,now(),now()),
(6,6,"サイダー","さいだー","人は誰もが皆、あの夏の匂いを覚えている。それは望郷の類か、救済を希うモノだったのであろうか。",3,100,"./images","Cider.jpg",now(),"YAMAGUCHI",1,now(),now()),
(7,7,"お茶","おちゃ","日本古代から親しまれているお茶。侘び寂びの心、日本人魂が蘇る一杯をどうぞ。",3,150,"./images","Tea.jpg",now(),"YAMAGUCHI",1,now(),now()),
(8,8,"ビール","びーる","仕事終わりの一杯の品。のどごし最高、１年分お安くなってます。",3,300,"./images","Beer.jpg",now(),"YAMAGUCHI",1,now(),now()),
(9,9,"オレンジジュース","おれんじじゅーす","私の好物なので販売中止",3,100,"./images","Orange Juice.jpg",now(),"YAMAGUCHI",1,now(),now()),
(10,10,"タピオカドリンク","たぴおかどりんく","原材料に対しての利益率高め、ぜひ買ってね！",3,700,"./images","Tapioca Drink.jpg",now(),"YAMAGUCHI",1,now(),now()),
(11,11,"クッキー","くっきー","サクッと手に取りやすいおいしい焼き菓子",4,1100,"./images","Cookie.jpg",now(),"ヤマグチ製菓",1,now(),now()),
(12,12,"マフィン","まふぃん","従来貴婦人をあたためた「マフ」の代わりにてを温めるものとして「マフィン」と呼ぶようになったそうです。",4,200,"./images","Muffin.jpg",now(),"ヤマグチ製菓",1,now(),now()),
(13,13,"バウムクーヘン","ばうむくーへん","樹木の年輪のような同心円状の模様が特徴のドイツ発祥のケーキ。",4,300,"./images","Baumkuchen.jpg",now(),"ヤマグチ製菓",1,now(),now()),
(14,14,"ゴマプリン","ごまぷりん","プリンの滑らかさはそのままに後味さっぱりとした黒ゴマのプリン。",4,100,"./images","Sesame Pudding.jpg",now(),"ヤマグチ製菓",1,now(),now()),
(15,15,"黒あめ","くろあめ","黒砂糖を使っているので、独特の風味とコクを味わうことができます。",4,150,"./images","Candy.jpg",now(),"ヤマグチ製菓",1,now(),now()),
(16,16,"分度器","ぶんどき","計算いらずで角度を測れるおすすめの文房具です。",5,100,"./images","Protractor.jpg",now(),"山口文房具店",1,now(),now()),
(17,17,"消しゴム","けしごむ","何でも消せる消しゴム。",5,100,"./images","Eraser.jpg",now(),"山口文房具店",1,now(),now()),
(18,18,"ハサミ","はさみ","切れ味抜群！カミが切れるハサミ。そうカミがね。",5,200,"./images","Scissors.jpg",now(),"山口文房具店",1,now(),now()),
(19,19,"鉛筆","えんぴつ","2Bのえんぴつ。細い線から太い線までなめらかに書けます。",5,500,"./images","Pen.jpg",now(),"山口文房具店",1,now(),now()),
(20,20,"シャープペンシル","しゃーぷぺんしる","携帯に便利なショートサイズのシャープペンシル。",5,100,"./images","Mechanicl Pencil.jpg",now(),"山口文房具店",1,now(),now());
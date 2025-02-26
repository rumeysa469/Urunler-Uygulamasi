import 'package:flutter/material.dart';
import 'package:urunler_app/data/entity/urunler.dart';
import 'package:urunler_app/ui/views/detay_sayfa.dart';

class AnaSayfa extends StatefulWidget{
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  Future<List<Urunler>> urunleriYukle() async {
    var urunler_listesi = <Urunler>[];
    var u1 = Urunler(id: 1, ad: "Macbook Pro", resim: "bilgisayar.png" , fiyat: 43000);
    var u2 = Urunler(id: 2, ad: "Rayban Club Master", resim: "gozluk.png", fiyat: 2500);
    var u3 = Urunler(id: 3, ad: "Sony ZX Series", resim: "kulaklik.png", fiyat: 40000);
    var u4 = Urunler(id: 4, ad: "Gio Armani", resim: "parfum.png", fiyat: 2000);
    var u5 = Urunler(id: 3, ad: "Casio X Series", resim: "saat.png", fiyat: 8000);
    var u6 = Urunler(id: 3, ad: "Dyson V8", resim: "supurge.png", fiyat: 18000);
    var u7 = Urunler(id: 3, ad: "Iphone 13", resim: "telefon.png", fiyat: 32000);
    urunler_listesi.add(u1);
    urunler_listesi.add(u2);
    urunler_listesi.add(u3);
    urunler_listesi.add(u4);
    urunler_listesi.add(u5);
    urunler_listesi.add(u6);
    urunler_listesi.add(u7);
    return urunler_listesi;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ürünler"),),
      body: FutureBuilder<List<Urunler>>(
        future: urunleriYukle(),
        builder: (context,snapshot){
          if (snapshot.hasData){ // burada veri var mı yok mu kontrolu yapıyoruz eğe yoksa elseye atar ve boş sayfa gösterirr
            var urunler_listesi= snapshot.data; // urunler listesinde ki tüm verileri getirivek bana
            return ListView.builder( // gelen verileir listelesin diye listview yapısını kullandık
                itemCount: urunler_listesi!.length , //bu satırda kac adet listemiz olsun diye yazıldı yani urunle_listesindeki adet ladar listsmiz olucak bundan dolayı length kullandık
                itemBuilder: (context , indeks){ //0 1 2 3 4 5 6. indeksler
                  var urun = urunler_listesi[indeks]; // burda da indeksimiz urunle_listesinin her bir elemanını getirim urunlere atar
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(urun: urun)));
                      // yukarıda ki kod satırı card daki bulunan kutuya tıklayınca bizi detay sayfasına götürür
                    },
                    child: Card( // card yapısı bizim listemzide ki kutucuk yapısı gibi düşünebiliriz bu kutunun içinde düzenlemeler yapacağız yani Row ile yatayda resim eklicez ve column yapısı ile dikey olarak bilgileri sıaralayacğız
                      child: Row(
                        children: [ // bu kısım kutumuzdaki resim görseli içindi
                          Padding(
                            padding: const EdgeInsets.all(8.0), // padding ile kutularımız arasında boşluk bıraktık
                            child: SizedBox( width: 128, height: 128, //sizebox ile kutularımızın boyutunu ayarladık
                                child: Image.asset("resimler/${urun.resim}")// bu satırda assetdeki resimlerden geliyor
                            ),
                          ), 
                          Column( crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(urun.ad),
                              const SizedBox(height: 10,), // bu satırda ki kodumuz urun adı ve fiyatı arasında 10 birim boşluk bırakacak
                              Text("${urun.fiyat} tl", style:  const TextStyle(fontSize: 20),),
                              const SizedBox(height: 10,), // burda da aynı işelm var fiyat ile sepete ekle arasında boşluk vardır
                              ElevatedButton(onPressed: (){
                                print("${urun.ad} sepete aklendi");
                              }, child: const Text("Sepet Ekle"))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
            );

          }else{
            return const Center();
          }
        },
      ),
    );
  }
}

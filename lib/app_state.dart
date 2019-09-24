import 'package:flutter/material.dart';

import 'postVars.dart';

class AppState extends InheritedWidget {

  String barcode = "";
  String url = "";
  final String rsaUrl = "http://tblid.nl/wp-json/tblid/v1/RSAGenerator";
  String domainname = "a";
  String jsontext = "none";
  String httphttps = "http(s)";
  bool httpsCBValue = false;
  bool secureCommunication = false;
  String webPubKey = "webpubkey";
  String localEmail = "localEmail";
  String localPubKey = "-----BEGIN PUBLIC KEY-----\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAtyBk8GCjGF9DjRTLFN3Q\nVrYDEYUWjYgmAWmml9DpLPyQGtdSSF7R4QoCM5jiXlSwZ2w3dvzJr8iRbJ+xhI\/S\nUs3lJ2kkMG3XZ5aQOHkJvB1eTK6+VHiH4cYo84kgj5kStOG59TVFLcbuTxYqpWuR\n4V1WCZXksLLnzpsi906fh4g\/wnQ88BVbvRuDby5HT6wTAYyeReuFatdNaOYt3HpO\n3tMzFuZhOFxLo+nVcTYltb3BBB1wQVwfYydLTki89UMqF3V+q601kzGsuwP5zBDj\nH0Ny\/YXY740cB5EeWHcNlOrUmhfyJ9Ykp8COFIaZisHSoTeMDEL7bJzwxVaZo5or\nHd4mXF5j5j422uKzCae1xoyWiOXI6vZCGY2WnMx2tsNxjEVM8p+63wTTCKYY50Iu\nE9B+YihJx\/R0JrjYQ9Ei9tWM6YrJBvhhxVDlvp\/1EdQ\/hQV0tdkWEIUIQU8BRPFS\nq4l8R6KfMZ1km+rgRJ\/d7ipi3O7QAuNZ0IwLMirSnuTshdPLrzsnYtQR+tbdAIWn\nI+AtppLJeMqaxG5MOBLhnCOhRktAyvKbxH4xh8k\/+8A0mIPSk6t2uV1MvJzsPIw3\nccPu8EoCHvPEJTkLUlhO\/sCxMlWMI40Bppbp8MhRXvjibA6w7xflJWEeBxPkVyIB\nZFmZtK24UxNeqNK3bDz4Q+kCAwEAAQ==\n-----END PUBLIC KEY-----\n";
  String localPrivKey = "-----BEGIN PRIVATE KEY-----\nMIIJQwIBADANBgkqhkiG9w0BAQEFAASCCS0wggkpAgEAAoICAQC3IGTwYKMYX0ON\nFMsU3dBWtgMRhRaNiCYBaaaX0Oks\/JAa11JIXtHhCgIzmOJeVLBnbDd2\/MmvyJFs\nn7GEj9JSzeUnaSQwbddnlpA4eQm8HV5Mrr5UeIfhxijziSCPmRK04bn1NUUtxu5P\nFiqla5HhXVYJleSwsufOmyL3Tp+HiD\/CdDzwFVu9G4NvLkdPrBMBjJ5F64Vq101o\n5i3cek7e0zMW5mE4XEuj6dVxNiW1vcEEHXBBXB9jJ0tOSLz1QyoXdX6rrTWTMay7\nA\/nMEOMfQ3L9hdjvjRwHkR5Ydw2U6tSaF\/In1iSnwI4UhpmKwdKhN4wMQvtsnPDF\nVpmjmisd3iZcXmPmPjba4rMJp7XGjJaI5cjq9kIZjZaczHa2w3GMRUzyn7rfBNMI\nphjnQi4T0H5iKEnH9HQmuNhD0SL21YzpiskG+GHFUOW+n\/UR1D+FBXS12RYQhQhB\nTwFE8VKriXxHop8xnWSb6uBEn93uKmLc7tAC41nQjAsyKtKe5OyF08uvOydi1BH6\n1t0Ahacj4C2mksl4yprEbkw4EuGcI6FGS0DK8pvEfjGHyT\/7wDSYg9KTq3a5XUy8\nnOw8jDdxw+7wSgIe88QlOQtSWE7+wLEyVYwjjQGmlunwyFFe+OJsDrDvF+UlYR4H\nE+RXIgFkWZm0rbhTE16o0rdsPPhD6QIDAQABAoICAGJqiXTaKqzNfctTcnTrZK1F\nMk73HJDBq9M0iXCruLURowyZzcHRG7B6pYY\/UuDpWMisUv6iim3rN6SOCmQ4uwr\/\nVnkgu28\/iPVF6IpBGmc7zVMe0nEpObWvvpBrkNE7rd8CNONAVsZsU+SzAAZY0lSw\nya1rHjWMYKIbo+YPHhNDuShzOdC5Wc0+\/RsCXxbFXo2FmgXvtosd3J9UnS8RmFOO\nY7WZ6IPWrlwQLkKinA+ZRCNHAu5NaRzroEAZPVv+VZ+36HSxKMrLdo4na9cs+DL0\nF9eCWH0ddAPpDMr0aJswvUN3PRAFuTtic7k6QUheNCmqZZytXtwXWBpmGTngf+yr\njG\/IFEI4zmEnNYmvUpf0GFGPkkxCrmrJglwn\/A3m9Ai3Xu7s4VvZdncbARjfaugm\nxMfb+EtTzbScmyIjCHkHd3aHmYfcU5pj\/GKdKcbSWwBdRuld2agy7kxBiK3wq67D\nnO5IF\/Plo\/FicFuAw8yuIHHT5lOCQPoRIpDyMJ8z75WsthI0xNX7nMv6W0QZFi3S\nrf7Mct8+W4vHHemh+2fWVQB8IJxQi11d3dw7DY+O4NsvkUHiV+zMZHwSGj5P2Emk\nraQDRFs4vmP56eUHg9KOerOQOrKAnI\/qZw4jrt5TW3OqBSIIpl2d697tAFNZKFIu\n+NlP6fV+w3iH7ZgGq7bRAoIBAQDd1anI15fVwwN0WjeJT6FvR25Yj01m+B4cfdwM\nuMGNdt7nRj\/MaRJ8eBGPd8n2ByQQGEdOxT27t4WctzMvekAP0iaY15e17l2mMm2T\nk3sdRfrNDMKMxBxbtyv+wF0wbgUl7sKQuUup3aUGM3b2Du81neErwm\/OEM2OExs5\nZPmHfGB2fFmeuji3\/yxCViE2aW0WpX2awI4I4AU6GkNVdEGt61Xd3mcu3SGa3eAv\n0PNCj6LdeA2C9RyZ5h\/8AULHUt38WfzMZAZD\/tF9jZYC2VJ2ZvpcWKhdIq\/CJUBS\ncTGj8LBrInXKGT6crVwSieL4iSYOHd8SQ1AedWU2pD2YFiZtAoIBAQDTVJOWh21Q\nEAv8CC3Cd2QPnuJS\/eKSwEd0hN9nkVDz0qF7A9q80ISe12kTPaW8aB9iOQlKgtKK\nmbk3hK\/5pywvuI1L8JwklsDRDNRpzIsQA4sTc5jQzuWkY4dxZ7cNf1rAeWE+bCj4\nA1Gzps6v8N7jdme7OyqLgIZ71MsxlQ9BDnnky2gNVy\/KUByN6wjh1dH+bN77D5WZ\nPv6JLBIIRtqgEJWonvuqZRVE3BMMcWfOJ0CVd0ZHfE4usdutd9WFYJgiNZeTRlHd\nxnhieeJDu65\/YjYXaBlaKk3zR\/8BLKIaqSD8ZG0B4ew3b+JVTSojHpmMIOl7Ew1u\ntTaH6zTVttXtAoIBAQCUspY+tJVoinIUWi0D88bIqt8Cqfw+W28DtjH8rRPA2b+M\n04AMaxojKPDMdIWCT0MTLtMNsBUzcU80v3CmEJJEiJ+qsElXgFJyBzeARsmt06zM\nKhN2\/DXuHJh3CUbuIbF9vc\/Z5vsbACGQSIsjYNtj21KGXK1JOeYvqAsFq\/O\/p9WZ\nVr1UMou2emuWg9l7eavQFFpfk1ciB9g5HEWqUGV+SVOjh2Mu\/Ld78eJG6w9EvLd1\nMPYNpHPpjWI\/MDEtHxUCBOf5scqpZXPTb0bw3e\/ywhBsOlmRJKEfyIyXNp0JwVrg\nVZcTQ1y+9U3Ud20XIAfMSqWuvkRERnjz6aAIBED5AoIBAHem4VFPKDM2grKWJuJ+\nGqdFfDslCE2ylEKCoMLQ4hbK4Sb3TbeuEAinShTcyKPeCDbiuEH5xB85Xkby13fw\nkPIL+eRPPPjyagVy0Cl+6BWPDAVdY96F5junJp6s7FW2D7n+f3KKZr\/VkUK4ZTn0\nlR4QgjbeDv6hLIOcPde638Ij4hwKlsVG4gYYSbKIqqTDHXyCQ9W+QyNbKV6dFzCc\nfVg3S6UHLtKRHPO57wcShoWQb96wg5gh51pE1W5n9Prpb\/megk2eeOeqYarP+64B\n65CwGJQ0GnaUkUH3N4iArt+NduGwMo\/oTIguzuUhJYRw5NsUH13Rsb9G1rMqFuYR\n+RkCggEBANWhAc4RjZD1zkg3fqDq7UXoliIR3RmeR3srQO4g792mNsLSpSEf88bL\n\/BgBbIXebebEVi+kljOtofneL29QCuQhULswJk7UuCOUFjZcnkaKHhixS6eMlajY\nJX7YWVmVHMXpnaflzmGyiqKeMmbz1N1vSVcMDElzhN6LeGrOJg7ri\/6kFmQFeU\/6\nZXeQdmrrUcZy2Q5dLe6xbnWnIs2rdBTcDWXabEqXpoQ6bif9gDw6FP6lu+oHZe7T\npGkqL8cK5mM\/MwvvBU2tMEBjtBQdGq\/J+53P83+8VZMh+0UBD9YIeIfLgOg9mBds\n\/C9IzN2QvqUWmMwRLxj34BdZFdoAI+I=\n-----END PRIVATE KEY-----\n";

    PostVars postVars = PostVars();


  AppState({Key key,Widget child}) : super(key:key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

    static AppState of(BuildContext context) =>
        context.inheritFromWidgetOfExactType(AppState);

}
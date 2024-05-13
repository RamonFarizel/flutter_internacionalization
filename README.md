# Internacionalização com Flutter


Implementando a internacionalização da sua aplicação flutter.
Exemplo baseado na [documentação oficial](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization).

### 1. Adicione os pacotes.

```
flutter pub add flutter_localizations --sdk=flutter

flutter pub add intl:any
```

### 2. Adicione as configurações necessárias:

**2.1** `Pubspec.yaml`:
```
flutter:
  generate: true
```

**2.2** Crie um arquivo `l10n.yaml` da raiz do projeto.

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
preferred-supported-locales: [en, pt_BR]
```

### 3. Crie os arquivos `.arb`
exemplo: `app_en.arb`, `app_pt.arb` `app_pt_br.arb`

> [!Warning]  
> no caso do PT BR precisamos incluir um arquivo de fallback `app_pt.arb`.

```json
{
  "helloWorld": "Hello World!",
  "@helloWorld": {
    "description": "The conventional newborn programmer greeting"
  }
}
```

### 4 - Gere os arquivos

Aqui temos 3 opções diferentes para gerar os arquivos:

`flutter pub get`, `flutter run` ou `flutter gen-l10n`


### 5 Atualize o MaterialApp

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const MaterialApp(
  title: 'Exemplo Internacionalização',
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: const FirstPage(),
);
```

### 6 Utilizando o AppLocalizations no nosso App

```dart
AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
```

Podemos facilitar um pouco a escrita criando uma `extension` para o `BuildContext`

```dart
extension AppLocalizationsExtension on BuildContext {
  AppLocalizationsExtension get intl => AppLocalizations.of(this)!;
}
```

```dart
AppBar(
        title: Text(context.appIntl.helloWorld),
      ),
```

---

# Pacote auxiliar

> [!NOTE]  
> A implementação dessa abordagem está na branch: `flutter_util`

Na abordagem anterior temos uma desvantagem. Os arquivos de `l10n` não são gerados automaticamente, o que nos força a rodar os comandos da `etapa 4` todas as vezes em que algo é alterado.

Para resolver isso vamos usar o pacote [intl_util](https://pub.dev/packages/intl_utils/install)

> [!Tip]  
> Utlize a extensão Flutter Intl do [VS Code](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl) ou [Android Studio](https://plugins.jetbrains.com/plugin/13666-flutter-intl) para ter as mudanças refletidas no seu seu código automaticamente.



### 1. Instalação 

```
dart pub add intl_utils
```

Execute apenas umas vez para ativar o pacote:

```
flutter pub global activate intl_utils
``` 

Execute o comando para gerar os arquivos:

```
dart run intl_utils:generate
```

### 2. Atualize o pubspec.yaml

```yaml
flutter_intl:
  enabled: true
  arb_dir: lib/l10n/idiomas
  output_dir: lib/l10n/
```

### 3. Atualize o MaterialApp

```dart
return MaterialApp(
      title: 'Exemplo Internacionalização',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const FirstPage(),
    );
```

### 4. Atualize a AppLocalizationsExtension


**Antes**

```dart
extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get appIntl => AppLocalizations.of(this)!;
}
```

**Depois**

```dart
extension AppLocalizationsExtension on BuildContext {
  S get appIntl => S.of(this);
}
```


> [!TIP]
> Atualize o `.gitignore` para não subir os arquivos gerados:
> `**/generated/` 

---
# Arquivos .ARB 
Recomendo dar uma olhada nos arquivos [.arb](lib/l10n/app_en.arb).
Agrupei alguns exemplos interessantes da documentação.

Também é possível fazer uso do [ARB Editor](https://marketplace.visualstudio.com/items?itemName=Google.arb-editor) para facilitar na escrita e na verificação da sintaxe.



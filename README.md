# Internacionalização com Flutter


Implementando a internacionalização da sua aplicação flutter.
Exemplo baseado na [documentação oficial](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization).

### 1. Adicionar os pacotes.

```
flutter pub add flutter_localizations --sdk=flutter

flutter pub add intl:any
```

### 2. Adicionando as configurações necessárias:

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

### 3. Criar os arquivos `.arb`
exemplo: `app_en.arb`, `app_pt.arb` `app_pt_br.arb`

> [!Atenção]  
> no caso do PT BR precisamos incluir um arquivo de fallback `app_pt.arb`.

```json
{
  "helloWorld": "Hello World!",
  "@helloWorld": {
    "description": "The conventional newborn programmer greeting"
  }
}
```

### 4 - Gerando os arquvios

Aqui temos 3 opções diferentes para gerar os arquivos:

`flutter pub get`, `flutter run` ou `flutter gen-l10n`


### 5 Ajustando o MaterialApp

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const MaterialApp(
  title: 'Localizations Sample App',
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
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
  get intl => AppLocalizations.of(this)!;
}
```

```dart
AppBar(
        title: Text(context.appIntl.helloWorld),
      ),
```

---

## Pacote auxiliar

Na abordagem anterior temos uma desvantagem. Os arquivos de `l10n` não são gerados automaticamente, o que nos força a rodar os comandos da `etapa 4` todas as vezes em que algo é altedado.

Para resolver isso vamos usar o pacote [intl_util](https://pub.dev/packages/intl_utils/install)

### 1. instalação 

```
dart pub add intl_utils
```

Execute apenas umas vez para ativar o pacote:

```
flutter pub global activate intl_utils
``` 

Execute o comando para gerar os arquivos:

```
flutter pub run intl_utils:generate
```



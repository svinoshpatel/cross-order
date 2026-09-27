# CrossOrder
Наскрізний проєкт з крос-платформного програмування.
Предметна область: Замовлення. Сутності: Customer, Product, Order, OrderLine.
Призначення: оформлення замовлень і підрахунок сум.
## Структура

```text
.
├── CrossOrder.sln
├── README.md
└── src
    ├── Cli
    ├── Cli.csproj
    ├── Program.cs
    └── Core
        ├── Core.csproj
        ├── Domain
        ├── Dto
        ├── EnvironmentalInfo.cs
        └── Storage
```
## Запуск
`dotnet build`

`dotnet run --project src/Cli`

## Публікація
- framework-dependent версія:
  `dotnet publish src/Cli -c Release -r osx-arm64 --self-contained false`


- self-contained версія:
  `dotnet publish src/Cli -c Release -r osx-arm64 --self-contained true`
## Середовище
.NET SDK 10.0, macOS 26.5.0
## Таблиця RID
| RID       |                                     Режим | Розмір publish | Потрібен runtime |
|-----------|------------------------------------------:|---------------:|-----------------:|
| osx-arm64 |                            self-contained |          83 MB |               ні |
| osx-arm64 |                       framework-dependent |         162 KB |    так (.NET 10) |
| osx-arm64 |   self-contained з PublishSingleFile=true |        76,4 MB |               ні |
| osx-arm64 |      self-contained з PublishTrimmed=true |        21.6 MB |               ні |
| win-x64   |                            self-contained |       80,4  MB |               ні |
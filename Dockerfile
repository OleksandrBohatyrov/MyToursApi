FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["MyToursApi.csproj", "./"]
RUN dotnet restore "MyToursApi.csproj"
COPY . .
RUN dotnet publish "MyToursApi.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MyToursApi.dll"]

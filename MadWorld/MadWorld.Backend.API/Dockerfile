﻿FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["MadWorld.Backend.API/MadWorld.Backend.API.csproj", "MadWorld.Backend.API/"]
RUN dotnet restore "MadWorld.Backend.API/MadWorld.Backend.API.csproj"
COPY . .
WORKDIR "/src/MadWorld.Backend.API"
RUN dotnet build "MadWorld.Backend.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "MadWorld.Backend.API.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MadWorld.Backend.API.dll"]
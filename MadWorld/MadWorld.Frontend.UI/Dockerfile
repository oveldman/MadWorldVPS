﻿FROM  --platform=$BUILDPLATFORM nginx:latest AS base
ARG BUILDPLATFORM
EXPOSE 80
EXPOSE 443

FROM  --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILDPLATFORM

WORKDIR /src
COPY ["MadWorld.Frontend.UI/MadWorld.Frontend.UI.csproj", "MadWorld.Frontend.UI/"]
RUN dotnet restore "MadWorld.Frontend.UI/MadWorld.Frontend.UI.csproj"
COPY . .
WORKDIR "/src/MadWorld.Frontend.UI"
RUN dotnet build "MadWorld.Frontend.UI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "MadWorld.Frontend.UI.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
COPY --from=publish /app/publish/wwwroot /usr/share/nginx/html

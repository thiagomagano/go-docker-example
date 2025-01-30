# Primeira etapa: construir o executável
FROM golang:1.21-alpine AS builder

WORKDIR /app

# Copiar os arquivos do módulo
COPY go.mod .

# Baixar dependências
RUN go mod download

# Copiar o código fonte
COPY . .

# Compilar o aplicativo
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Segunda etapa: criar a imagem final
FROM alpine:latest

WORKDIR /app

# Copiar o executável da etapa anterior
COPY --from=builder /app/main .

# Expor a porta 8080
EXPOSE 8080

# Executar o aplicativo
CMD ["./main"]
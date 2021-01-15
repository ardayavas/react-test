FROM node:alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install
# volume'u ref verdigimiz icin bunu silebliriz ama bırakmak daha iyi.
# çünkü bu dosyayı production'da da kullanmak isteyebiliriz.
COPY . .

RUN npm run build
# /app/build is all the folder we need
EXPOSE 80
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

#nginx build'i içinde default olarak start komutu olduğundan biz bi daha başlatmıyoruz.
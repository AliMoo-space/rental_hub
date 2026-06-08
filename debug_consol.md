Restarted application in ٣٧٣ms.
[Auth] 🔑 TokenStorageHelper: Retrieved access token
       Retrieved token type: String
       Returned token type: String
       Returned token preview: eyJhbGciOiJI...-dbXSI
[HTTP] HTTP GET /api/UserProfile
       skipAuth=false
       queryParameters={}
       data=<none>
[Subscription] SubscriptionRemoteDataSourceImpl.getActiveSubscription: attempt 1/3
               GET /api/UserDashboard/subscription
[HTTP] HTTP GET /api/UserDashboard/subscription
       skipAuth=false
       queryParameters={}
       data=<none>
[HTTP] HTTP GET /api/Community/requests
       skipAuth=false
       queryParameters={pageNumber: 1, pageSize: 10}
       data=<none>
[HTTP] HTTP GET /api/Community/my-requests
       skipAuth=false
       queryParameters={pageNumber: 1, pageSize: 10}
       data=<none>
[HTTP] HTTP GET /api/Community/my-requests/offers
       skipAuth=false
       queryParameters={}
       data=<none>
[HTTP] HTTP GET /api/Community/my-offers
       skipAuth=false
       queryParameters={}
       data=<none>
[Instrumentation] PagingController count start fetchPage 1
[Instrumentation] Repository count start
[Instrumentation] API count start: getProducts page 1
[HTTP] HTTP GET /api/Product
       skipAuth=false
       queryParameters={pageNumber: 1, pageSize: 10}
       data=<none>
[HTTP] HTTP GET /api/Categories
       skipAuth=false
       queryParameters={PageNumber: 1, PageSize: 100}
       data=<none>
[Instrumentation] Cubit state transition: ProductInitial -> ProductLoading
[Instrumentation] PagingController count start fetchPage 1
[Instrumentation] Repository count start
[Instrumentation] API count start: getProducts page 1
[HTTP] HTTP GET /api/Product
       skipAuth=false
       queryParameters={pageNumber: 1, pageSize: 10}
       data=<none>
[HTTP] HTTP GET /api/Chat/conversations
       skipAuth=false
       queryParameters={}
       data=<none>
[Auth] AuthInterceptor.onRequest: GET https://rentalplatform.runasp.net/api/UserProfile
       skipAuth=false
[Auth] AuthInterceptor.onRequest: attached Authorization header
       Token preview: eyJhbGci...UD-dbXSI
[Auth] AuthInterceptor.onRequest: GET https://rentalplatform.runasp.net/api/UserDashboard/subscription
       skipAuth=false
[Auth] AuthInterceptor.onRequest: attached Authorization header
       Token preview: eyJhbGci...UD-dbXSI
[Auth] AuthInterceptor.onRequest: GET https://rentalplatform.runasp.net/api/Community/requests?pageNumber=1&pageSize=10
       skipAuth=false
[Auth] AuthInterceptor.onRequest: attached Authorization header
       Token preview: eyJhbGci...UD-dbXSI
[Auth] AuthInterceptor.onRequest: attached Authorization header
       Token preview: eyJhbGci...UD-dbXSI
[Auth] AuthInterceptor.onRequest: GET https://rentalplatform.runasp.net/api/Community/my-requests?pageNumber=1&pageSize=10
       skipAuth=false
[Auth] AuthInterceptor.onRequest: GET https://rentalplatform.runasp.net/api/Community/my-requests/offers
       skipAuth=false
[Auth] AuthInterceptor.onRequest: attached Authorization header
       Token preview: eyJhbGci...UD-dbXSI
[Auth] AuthInterceptor.onRequest: GET https://rentalplatform.runasp.net/api/Community/my-offers
       skipAuth=false
[Auth] AuthInterceptor.onRequest: attached Authorization header
       Token preview: eyJhbGci...UD-dbXSI
[Auth] AuthInterceptor.onRequest: GET https://rentalplatform.runasp.net/api/Product?pageNumber=1&pageSize=10
       skipAuth=false
[Auth] AuthInterceptor.onRequest: attached Authorization header
       Token preview: eyJhbGci...UD-dbXSI
[Auth] AuthInterceptor.onRequest: GET https://rentalplatform.runasp.net/api/Categories?PageNumber=1&PageSize=100
       skipAuth=false
[Auth] AuthInterceptor.onRequest: attached Authorization header
       Token preview: eyJhbGci...UD-dbXSI
[Auth] AuthInterceptor.onRequest: GET https://rentalplatform.runasp.net/api/Product?pageNumber=1&pageSize=10
       skipAuth=false
[Auth] AuthInterceptor.onRequest: attached Authorization header
       Token preview: eyJhbGci...UD-dbXSI
[Auth] AuthInterceptor.onRequest: GET https://rentalplatform.runasp.net/api/Chat/conversations
       skipAuth=false
[Auth] AuthInterceptor.onRequest: attached Authorization header
       Token preview: eyJhbGci...UD-dbXSI
flutter:
flutter: ╔╣ Request ║ GET
flutter: ║  https://rentalplatform.runasp.net/api/UserProfile
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Headers
flutter: ╟ Content-Type: application/json
flutter: ╟ Accept: application/json
flutter: ╟ Authorization:
flutter: ║ Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJlbWFpbCI6ImFs
flutter: ║ aWxvbW84MzZAZ21haWwuY29tIiwianRpIjoiZDA2OTZkZWQtM2Q5Zi00NDdhLTlkNmMtMTMzZTgyZDI1YjU2IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5v
flutter: ║ cmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJodHRw
flutter: ║ Oi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhbGlsb21vODM2QGdtYWlsLmNvbSIsImZ1
flutter: ║ bGxOYW1lIjoiQWxpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6
flutter: ║ MTc4MTAzODQ2NiwiaXNzIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5uZXQvIiwiYXVkIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5u
flutter: ║ ZXQvIn0.rcDWAnok178cR05OTzRwB_MCUdQRXtCPuz-UD-dbXSI
flutter: ╟ contentType: application/json
flutter: ╟ responseType: ResponseType.json
flutter: ╟ followRedirects: true
flutter: ╟ connectTimeout: 0:00:15.000000
flutter: ╟ receiveTimeout: 0:00:30.000000
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Extras
flutter: ╟ skipAuth: false
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Request ║ GET
flutter: ║  https://rentalplatform.runasp.net/api/UserDashboard/subscription
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Headers
flutter: ╟ Content-Type: application/json
flutter: ╟ Accept: application/json
flutter: ╟ Authorization:
flutter: ║ Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJlbWFpbCI6ImFs
flutter: ║ aWxvbW84MzZAZ21haWwuY29tIiwianRpIjoiZDA2OTZkZWQtM2Q5Zi00NDdhLTlkNmMtMTMzZTgyZDI1YjU2IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5v
flutter: ║ cmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJodHRw
flutter: ║ Oi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhbGlsb21vODM2QGdtYWlsLmNvbSIsImZ1
flutter: ║ bGxOYW1lIjoiQWxpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6
flutter: ║ MTc4MTAzODQ2NiwiaXNzIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5uZXQvIiwiYXVkIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5u
flutter: ║ ZXQvIn0.rcDWAnok178cR05OTzRwB_MCUdQRXtCPuz-UD-dbXSI
flutter: ╟ contentType: application/json
flutter: ╟ responseType: ResponseType.json
flutter: ╟ followRedirects: true
flutter: ╟ connectTimeout: 0:00:15.000000
flutter: ╟ receiveTimeout: 0:00:30.000000
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Extras
flutter: ╟ skipAuth: false
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Request ║ GET
flutter: ║  https://rentalplatform.runasp.net/api/Community/requests?pageNumber=1&pageSize=10
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Query Parameters
flutter: ╟ pageNumber: 1
flutter: ╟ pageSize: 10
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Headers
flutter: ╟ Content-Type: application/json
flutter: ╟ Accept: application/json
flutter: ╟ Authorization:
flutter: ║ Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJlbWFpbCI6ImFs
flutter: ║ aWxvbW84MzZAZ21haWwuY29tIiwianRpIjoiZDA2OTZkZWQtM2Q5Zi00NDdhLTlkNmMtMTMzZTgyZDI1YjU2IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5v
flutter: ║ cmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJodHRw
flutter: ║ Oi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhbGlsb21vODM2QGdtYWlsLmNvbSIsImZ1
flutter: ║ bGxOYW1lIjoiQWxpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6
flutter: ║ MTc4MTAzODQ2NiwiaXNzIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5uZXQvIiwiYXVkIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5u
flutter: ║ ZXQvIn0.rcDWAnok178cR05OTzRwB_MCUdQRXtCPuz-UD-dbXSI
flutter: ╟ contentType: application/json
flutter: ╟ responseType: ResponseType.json
flutter: ╟ followRedirects: true
flutter: ╟ connectTimeout: 0:00:15.000000
flutter: ╟ receiveTimeout: 0:00:30.000000
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Extras
flutter: ╟ skipAuth: false
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Request ║ GET
flutter: ║  https://rentalplatform.runasp.net/api/Community/my-requests?pageNumber=1&pageSize=10
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Query Parameters
flutter: ╟ pageNumber: 1
flutter: ╟ pageSize: 10
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Headers
flutter: ╟ Content-Type: application/json
flutter: ╟ Accept: application/json
flutter: ╟ Authorization:
flutter: ║ Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJlbWFpbCI6ImFs
flutter: ║ aWxvbW84MzZAZ21haWwuY29tIiwianRpIjoiZDA2OTZkZWQtM2Q5Zi00NDdhLTlkNmMtMTMzZTgyZDI1YjU2IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5v
flutter: ║ cmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJodHRw
flutter: ║ Oi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhbGlsb21vODM2QGdtYWlsLmNvbSIsImZ1
flutter: ║ bGxOYW1lIjoiQWxpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6
flutter: ║ MTc4MTAzODQ2NiwiaXNzIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5uZXQvIiwiYXVkIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5u
flutter: ║ ZXQvIn0.rcDWAnok178cR05OTzRwB_MCUdQRXtCPuz-UD-dbXSI
flutter: ╟ contentType: application/json
flutter: ╟ responseType: ResponseType.json
flutter: ╟ followRedirects: true
flutter: ╟ connectTimeout: 0:00:15.000000
flutter: ╟ receiveTimeout: 0:00:30.000000
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Extras
flutter: ╟ skipAuth: false
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Request ║ GET
flutter: ║  https://rentalplatform.runasp.net/api/Community/my-requests/offers
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Headers
flutter: ╟ Content-Type: application/json
flutter: ╟ Accept: application/json
flutter: ╟ Authorization:
flutter: ║ Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJlbWFpbCI6ImFs
flutter: ║ aWxvbW84MzZAZ21haWwuY29tIiwianRpIjoiZDA2OTZkZWQtM2Q5Zi00NDdhLTlkNmMtMTMzZTgyZDI1YjU2IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5v
flutter: ║ cmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJodHRw
flutter: ║ Oi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhbGlsb21vODM2QGdtYWlsLmNvbSIsImZ1
flutter: ║ bGxOYW1lIjoiQWxpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6
flutter: ║ MTc4MTAzODQ2NiwiaXNzIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5uZXQvIiwiYXVkIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5u
flutter: ║ ZXQvIn0.rcDWAnok178cR05OTzRwB_MCUdQRXtCPuz-UD-dbXSI
flutter: ╟ contentType: application/json
flutter: ╟ responseType: ResponseType.json
flutter: ╟ followRedirects: true
flutter: ╟ connectTimeout: 0:00:15.000000
flutter: ╟ receiveTimeout: 0:00:30.000000
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Extras
flutter: ╟ skipAuth: false
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Request ║ GET
flutter: ║  https://rentalplatform.runasp.net/api/Community/my-offers
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Headers
flutter: ╟ Content-Type: application/json
flutter: ╟ Accept: application/json
flutter: ╟ Authorization:
flutter: ║ Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJlbWFpbCI6ImFs
flutter: ║ aWxvbW84MzZAZ21haWwuY29tIiwianRpIjoiZDA2OTZkZWQtM2Q5Zi00NDdhLTlkNmMtMTMzZTgyZDI1YjU2IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5v
flutter: ║ cmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJodHRw
flutter: ║ Oi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhbGlsb21vODM2QGdtYWlsLmNvbSIsImZ1
flutter: ║ bGxOYW1lIjoiQWxpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6
flutter: ║ MTc4MTAzODQ2NiwiaXNzIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5uZXQvIiwiYXVkIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5u
flutter: ║ ZXQvIn0.rcDWAnok178cR05OTzRwB_MCUdQRXtCPuz-UD-dbXSI
flutter: ╟ contentType: application/json
flutter: ╟ responseType: ResponseType.json
flutter: ╟ followRedirects: true
flutter: ╟ connectTimeout: 0:00:15.000000
flutter: ╟ receiveTimeout: 0:00:30.000000
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Extras
flutter: ╟ skipAuth: false
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Request ║ GET
flutter: ║  https://rentalplatform.runasp.net/api/Product?pageNumber=1&pageSize=10
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Query Parameters
flutter: ╟ pageNumber: 1
flutter: ╟ pageSize: 10
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Headers
flutter: ╟ Content-Type: application/json
flutter: ╟ Accept: application/json
flutter: ╟ Authorization:
flutter: ║ Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJlbWFpbCI6ImFs
flutter: ║ aWxvbW84MzZAZ21haWwuY29tIiwianRpIjoiZDA2OTZkZWQtM2Q5Zi00NDdhLTlkNmMtMTMzZTgyZDI1YjU2IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5v
flutter: ║ cmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJodHRw
flutter: ║ Oi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhbGlsb21vODM2QGdtYWlsLmNvbSIsImZ1
flutter: ║ bGxOYW1lIjoiQWxpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6
flutter: ║ MTc4MTAzODQ2NiwiaXNzIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5uZXQvIiwiYXVkIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5u
flutter: ║ ZXQvIn0.rcDWAnok178cR05OTzRwB_MCUdQRXtCPuz-UD-dbXSI
flutter: ╟ contentType: application/json
flutter: ╟ responseType: ResponseType.json
flutter: ╟ followRedirects: true
flutter: ╟ connectTimeout: 0:00:15.000000
flutter: ╟ receiveTimeout: 0:00:30.000000
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Extras
flutter: ╟ skipAuth: false
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Request ║ GET
flutter: ║  https://rentalplatform.runasp.net/api/Categories?PageNumber=1&PageSize=100
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Query Parameters
flutter: ╟ PageNumber: 1
flutter: ╟ PageSize: 100
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Headers
flutter: ╟ Content-Type: application/json
flutter: ╟ Accept: application/json
flutter: ╟ Authorization:
flutter: ║ Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJlbWFpbCI6ImFs
flutter: ║ aWxvbW84MzZAZ21haWwuY29tIiwianRpIjoiZDA2OTZkZWQtM2Q5Zi00NDdhLTlkNmMtMTMzZTgyZDI1YjU2IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5v
flutter: ║ cmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJodHRw
flutter: ║ Oi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhbGlsb21vODM2QGdtYWlsLmNvbSIsImZ1
flutter: ║ bGxOYW1lIjoiQWxpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6
flutter: ║ MTc4MTAzODQ2NiwiaXNzIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5uZXQvIiwiYXVkIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5u
flutter: ║ ZXQvIn0.rcDWAnok178cR05OTzRwB_MCUdQRXtCPuz-UD-dbXSI
flutter: ╟ contentType: application/json
flutter: ╟ responseType: ResponseType.json
flutter: ╟ followRedirects: true
flutter: ╟ connectTimeout: 0:00:15.000000
flutter: ╟ receiveTimeout: 0:00:30.000000
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Extras
flutter: ╟ skipAuth: false
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Request ║ GET
flutter: ║  https://rentalplatform.runasp.net/api/Product?pageNumber=1&pageSize=10
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Query Parameters
flutter: ╟ pageNumber: 1
flutter: ╟ pageSize: 10
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Headers
flutter: ╟ Content-Type: application/json
flutter: ╟ Accept: application/json
flutter: ╟ Authorization:
flutter: ║ Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJlbWFpbCI6ImFs
flutter: ║ aWxvbW84MzZAZ21haWwuY29tIiwianRpIjoiZDA2OTZkZWQtM2Q5Zi00NDdhLTlkNmMtMTMzZTgyZDI1YjU2IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5v
flutter: ║ cmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJodHRw
flutter: ║ Oi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhbGlsb21vODM2QGdtYWlsLmNvbSIsImZ1
flutter: ║ bGxOYW1lIjoiQWxpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6
flutter: ║ MTc4MTAzODQ2NiwiaXNzIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5uZXQvIiwiYXVkIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5u
flutter: ║ ZXQvIn0.rcDWAnok178cR05OTzRwB_MCUdQRXtCPuz-UD-dbXSI
flutter: ╟ contentType: application/json
flutter: ╟ responseType: ResponseType.json
flutter: ╟ followRedirects: true
flutter: ╟ connectTimeout: 0:00:15.000000
flutter: ╟ receiveTimeout: 0:00:30.000000
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Extras
flutter: ╟ skipAuth: false
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Request ║ GET
flutter: ║  https://rentalplatform.runasp.net/api/Chat/conversations
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Headers
flutter: ╟ Content-Type: application/json
flutter: ╟ Accept: application/json
flutter: ╟ Authorization:
flutter: ║ Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJlbWFpbCI6ImFs
flutter: ║ aWxvbW84MzZAZ21haWwuY29tIiwianRpIjoiZDA2OTZkZWQtM2Q5Zi00NDdhLTlkNmMtMTMzZTgyZDI1YjU2IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5v
flutter: ║ cmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJlMzRhMWI2ZS00MzRkLTQ0ZTItODNiNi02YjNmMjc1MzZkYjQiLCJodHRw
flutter: ║ Oi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhbGlsb21vODM2QGdtYWlsLmNvbSIsImZ1
flutter: ║ bGxOYW1lIjoiQWxpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6
flutter: ║ MTc4MTAzODQ2NiwiaXNzIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5uZXQvIiwiYXVkIjoiaHR0cDovL3JlbnRhbHBsYXRmb3JtLnJ1bmFzcC5u
flutter: ║ ZXQvIn0.rcDWAnok178cR05OTzRwB_MCUdQRXtCPuz-UD-dbXSI
flutter: ╟ contentType: application/json
flutter: ╟ responseType: ResponseType.json
flutter: ╟ followRedirects: true
flutter: ╟ connectTimeout: 0:00:15.000000
flutter: ╟ receiveTimeout: 0:00:30.000000
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Extras
flutter: ╟ skipAuth: false
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Response ║ GET ║ Status: 200 OK  ║ Time: 408 ms
flutter: ║  https://rentalplatform.runasp.net/api/UserProfile
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Body
flutter: ║
flutter: ║    {
flutter: ║         "id": "e34a1b6e-434d-44e2-83b6-6b3f27536db4",
flutter: ║         "fullName": "Ali",
[HTTP] HTTP GET /api/UserProfile -> 200
       responseType=_Map<String, dynamic>
       responseBody={id: e34a1b6e-434d-44e2-83b6-6b3f27536db4, fullName: Ali, email: alilomo836@gmail.com, phoneNumber: 01551713043, nationalId: 1234567890, city: Mansoura, governorate: Mansoura, country: Egypt, sex: ذكر, imageUrl: /uploads/profiles/9ae2ed18-aace-449a-99ca-526c0a0579aa.jpg, idCardImage: /uploads/idcards/61bf5e08-afc6-4ca3-ad15-eb77501b1214.jpg, createdAt: 2026-05-15T18:51:57.3455202, lastLogin: 2026-06-08T20:54:26.4561213}
flutter: ║         "email": "alilomo836@gmail.com",
flutter: ║         "phoneNumber": "01551713043",
flutter: ║         "nationalId": "1234567890",
flutter: ║         "city": "Mansoura",
flutter: ║         "governorate": "Mansoura",
flutter: ║         "country": "Egypt",
flutter: ║         "sex": "ذكر",
flutter: ║         "imageUrl": "/uploads/profiles/9ae2ed18-aace-449a-99ca-526c0a0579aa.jpg",
flutter: ║         "idCardImage": "/uploads/idcards/61bf5e08-afc6-4ca3-ad15-eb77501b1214.jpg",
flutter: ║         "createdAt": "2026-05-15T18:51:57.3455202",
flutter: ║         "lastLogin": "2026-06-08T20:54:26.4561213"
flutter: ║    }
flutter: ║
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
[HTTP] HTTP GET /api/Community/my-requests/offers -> 200
       responseType=List<dynamic>
       responseBody=[]
flutter: ╔╣ Response ║ GET ║ Status: 200 OK  ║ Time: 431 ms
flutter: ║  https://rentalplatform.runasp.net/api/Community/my-requests/offers
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Body
flutter: ║
flutter: ║    [
flutter: ║    ]
flutter: ║
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Response ║ GET ║ Status: 200 OK  ║ Time: 437 ms
flutter: ║  https://rentalplatform.runasp.net/api/Community/my-requests?pageNumber=1&pageSize=10
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Body
flutter: ║
flutter: ║    {
flutter: ║         "items": []
flutter: ║         "totalCount": 0,
flutter: ║         "pageNumber": 1,
flutter: ║         "pageSize": 10,
flutter: ║         "totalPages": 0,
flutter: ║         "hasPrevious": false,
[HTTP] HTTP GET /api/Community/my-requests -> 200
       responseType=_Map<String, dynamic>
       responseBody={items: [], totalCount: 0, pageNumber: 1, pageSize: 10, totalPages: 0, hasPrevious: false, hasNext: false}
flutter: ║         "hasNext": false
flutter: ║    }
flutter: ║
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Response ║ GET ║ Status: 200 OK  ║ Time: 441 ms
flutter: ║  https://rentalplatform.runasp.net/api/Community/requests?pageNumber=1&pageSize=10
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Body
flutter: ║
flutter: ║    {
flutter: ║         "items": [
flutter: ║            {
flutter: ║                 "id": 10,
flutter: ║                 "userId": "cb4722ac-ac17-4215-bb91-1b8d4694ce19",
[HTTP] HTTP GET /api/Community/requests -> 200
       responseType=_Map<String, dynamic>
       responseBody={items: [{id: 10, userId: cb4722ac-ac17-4215-bb91-1b8d4694ce19, userName: Rawan Selima, userImage: /uploads/idcards/40e8f803-c956-4750-8504-847de9b0f070.jpeg, categoryId: 21, categoryName: صوره, subcategoryId: 1006, subcategoryName: test, governorate: كفر الشيخ, city: كفر الشيخ, address: طريق كفر الشيخ, طنطا, كفر الشيخ, 33717, مصر, title: hiiiiiiiiiiiiiii, budget: 2000.0, startDate: 2026-06-07T00:00:00, endDate: 2026-06-09T00:00:00, description: testtttttttttttttttttttttttttttttt, imageUrl: /uploads/community/a4dd5fa1-0d91-4ab4-bc08-a37f47238be5.png, status: Approved, rejectionReason: null, createdAt: 2026-06-06T23:19:59.956933, offersCount: 0}, {id: 8, userId: d95ab474-61e2-462c-bcfd-a5a1b17703fd, userName: Rawan Selima, userImage: /uploads/idcards/a8ac46b0-651b-414f-967c-aa27d5eb2b18.png, categoryId: 21, categoryName: صوره, subcategoryId: 1006, subcategoryName: test, governorate: القاهرة, city: ثان مدينة نصر, address: امتداد شارع السلام, ثان مدينة نصر, القاهرة, 11684, مصر, title: weeeeeeeeeeeeeee, budget: 500.0, startDate: 2026-06-24T00:00:00, endDate: 2026-06-27T00:00:00, description: arrrrrrrrrrrrrrrrrrrr, imageUrl: /uploads/community/0cff1ea9-3159-4bb4-a0e8-4deaa0b9e498.jpeg, status: Approved, rejectionReason: null, createdAt: 2026-06-06T22:45:13.3896516, offersCount: 0}, {id: 6, userId: 83e358a2-997c-4478-a698-380fb6f02353, userName: fouad, userImage: /uploads/idcards/83d68dd1-03e4-4d99-98ac-79d4813d32c6.png, categoryId: 21, categoryName: صوره, subcategoryId: 1006, subcategoryName: test, governorate: كفر الشيخ, city: كفر الشيخ, address: كفر الشيخ, 33717, مصر, title: laaaa, budget: 300.0, startDate: 2026-06-26T00:00:00, endDate: 2026-07-11T00:00:00, description: yesssssssssss, imageUrl: /uploads/community/7aece7ae-f2ce-429a-adbb-0a2f29216421.jpeg, status: Approved, rejectionReason: null, createdAt: 2026-06-06T22:42:57.9942505, offersCount: 0}, {id: 5, userId: 83e358a2-997c-4478-a698-380fb6f02353, userName: fouad, userImage: /uploads/idcards/83d68dd1-03e4-4d99-98ac-79d4813d32c6.png, categoryId: 1, categoryName: Electronics, subcategoryId: 102, subcategoryName: Xbox, governorate: كفر الشيخ, city: كفر الشيخ, address: كفر الشيخ, 33717, مصر, title: hi, budget: 300.0, startDate: 2026-06-07T00:00:00, endDate: 2026-06-09T00:00:00, description: testttt, imageUrl: /uploads/community/e51e67d2-e674-416d-bd89-1450eb15fd66.jpeg, status: Approved, rejectionReason: null, createdAt: 2026-06-06T22:42:11.40294, offersCount: 0}, {id: 3, userId: 83e358a2-997c-4478-a698-380fb6f02353, userName: fouad, userImage: /uploads/idcards/83d68dd1-03e4-4d99-98ac-79d4813d32c6.png, categoryId: 20, categoryName: fouad, subcategoryId: 1004, subcategoryName: ghanim, governorate: كفر السيخ, city: كفر الشيخ, address: طريق كفر الشيخ, طنطا, كفر الشيخ, 33717, مصر, title: فستان نبيتي, budget: 600.0, startDate: 2026-06-12T00:00:00, endDate: 2026-06-20T00:00:00, description: عايزه فسان سواريه ينفع خطوبه يكون صك , imageUrl: /uploads/community/0126e442-e1e3-46ff-8cb5-9eb425425ca9.png, status: Approved, rejectionReason: null, createdAt: 2026-06-06T16:58:06.3166838, offersCount: 0}, {id: 2, userId: 83e358a2-997c-4478-a698-380fb6f02353, userName: fouad, userImage: /uploads/idcards/83d68dd1-03e4-4d99-98ac-79d4813d32c6.png, categoryId: 1, categoryName: Electronics, subcategoryId: 102, subcategoryName: Xbox, governorate: سخا, city: كفر الشيخ, address: طريق كفر الشيخ, طنطا, كفر الشيخ, 33717, مصر, title: test, budget: 44.0, startDate: 2026-06-06T00:00:00, endDate: 2026-06-08T00:00:00, description: hello world, imageUrl: /uploads/community/635d5460-d4aa-4867-8b7e-c55fb375669b.png, status: Approved, rejectionReason: null, createdAt: 2026-06-06T16:47:07.1015343, offersCount: 0}], totalCount: 6, pageNumber: 1, pageSize: 10, totalPages: 1, hasPrevious: false, hasNext: false}
flutter: ║                 "userName": "Rawan Selima",
flutter: ║                 "userImage": "/uploads/idcards/40e8f803-c956-4750-8504-847de9b0f070.jpeg",
flutter: ║                 "categoryId": 21,
flutter: ║                 "categoryName": "صوره",
flutter: ║                 "subcategoryId": 1006,
flutter: ║                 "subcategoryName": "test",
flutter: ║                 "governorate": "كفر الشيخ",
flutter: ║                 "city": "كفر الشيخ",
flutter: ║                 "address": "طريق كفر الشيخ, طنطا, كفر الشيخ, 33717, مصر",
flutter: ║                 "title": "hiiiiiiiiiiiiiii",
flutter: ║                 "budget": 2000.0,
flutter: ║                 "startDate": "2026-06-07T00:00:00",
flutter: ║                 "endDate": "2026-06-09T00:00:00",
flutter: ║                 "description": "testtttttttttttttttttttttttttttttt",
flutter: ║                 "imageUrl": "/uploads/community/a4dd5fa1-0d91-4ab4-bc08-a37f47238be5.png",
flutter: ║                 "status": "Approved",
flutter: ║                 "rejectionReason": null,
flutter: ║                 "createdAt": "2026-06-06T23:19:59.956933",
flutter: ║                 "offersCount": 0
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 8,
flutter: ║                 "userId": "d95ab474-61e2-462c-bcfd-a5a1b17703fd",
flutter: ║                 "userName": "Rawan Selima",
flutter: ║                 "userImage": "/uploads/idcards/a8ac46b0-651b-414f-967c-aa27d5eb2b18.png",
flutter: ║                 "categoryId": 21,
flutter: ║                 "categoryName": "صوره",
flutter: ║                 "subcategoryId": 1006,
flutter: ║                 "subcategoryName": "test",
flutter: ║                 "governorate": "القاهرة",
flutter: ║                 "city": "ثان مدينة نصر",
flutter: ║                 "address": "امتداد شارع السلام, ثان مدينة نصر, القاهرة, 11684, مصر",
flutter: ║                 "title": "weeeeeeeeeeeeeee",
flutter: ║                 "budget": 500.0,
flutter: ║                 "startDate": "2026-06-24T00:00:00",
flutter: ║                 "endDate": "2026-06-27T00:00:00",
flutter: ║                 "description": "arrrrrrrrrrrrrrrrrrrr",
flutter: ║                 "imageUrl": "/uploads/community/0cff1ea9-3159-4bb4-a0e8-4deaa0b9e498.jpeg",
flutter: ║                 "status": "Approved",
flutter: ║                 "rejectionReason": null,
flutter: ║                 "createdAt": "2026-06-06T22:45:13.3896516",
flutter: ║                 "offersCount": 0
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 6,
flutter: ║                 "userId": "83e358a2-997c-4478-a698-380fb6f02353",
flutter: ║                 "userName": "fouad",
flutter: ║                 "userImage": "/uploads/idcards/83d68dd1-03e4-4d99-98ac-79d4813d32c6.png",
flutter: ║                 "categoryId": 21,
flutter: ║                 "categoryName": "صوره",
flutter: ║                 "subcategoryId": 1006,
flutter: ║                 "subcategoryName": "test",
flutter: ║                 "governorate": "كفر الشيخ",
flutter: ║                 "city": "كفر الشيخ",
flutter: ║                 "address": "كفر الشيخ, 33717, مصر",
flutter: ║                 "title": "laaaa",
flutter: ║                 "budget": 300.0,
flutter: ║                 "startDate": "2026-06-26T00:00:00",
flutter: ║                 "endDate": "2026-07-11T00:00:00",
flutter: ║                 "description": "yesssssssssss",
flutter: ║                 "imageUrl": "/uploads/community/7aece7ae-f2ce-429a-adbb-0a2f29216421.jpeg",
flutter: ║                 "status": "Approved",
flutter: ║                 "rejectionReason": null,
flutter: ║                 "createdAt": "2026-06-06T22:42:57.9942505",
flutter: ║                 "offersCount": 0
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 5,
flutter: ║                 "userId": "83e358a2-997c-4478-a698-380fb6f02353",
flutter: ║                 "userName": "fouad",
flutter: ║                 "userImage": "/uploads/idcards/83d68dd1-03e4-4d99-98ac-79d4813d32c6.png",
flutter: ║                 "categoryId": 1,
flutter: ║                 "categoryName": "Electronics",
flutter: ║                 "subcategoryId": 102,
flutter: ║                 "subcategoryName": "Xbox",
flutter: ║                 "governorate": "كفر الشيخ",
flutter: ║                 "city": "كفر الشيخ",
flutter: ║                 "address": "كفر الشيخ, 33717, مصر",
flutter: ║                 "title": "hi",
flutter: ║                 "budget": 300.0,
flutter: ║                 "startDate": "2026-06-07T00:00:00",
flutter: ║                 "endDate": "2026-06-09T00:00:00",
flutter: ║                 "description": "testttt",
flutter: ║                 "imageUrl": "/uploads/community/e51e67d2-e674-416d-bd89-1450eb15fd66.jpeg",
flutter: ║                 "status": "Approved",
flutter: ║                 "rejectionReason": null,
flutter: ║                 "createdAt": "2026-06-06T22:42:11.40294",
flutter: ║                 "offersCount": 0
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 3,
flutter: ║                 "userId": "83e358a2-997c-4478-a698-380fb6f02353",
flutter: ║                 "userName": "fouad",
flutter: ║                 "userImage": "/uploads/idcards/83d68dd1-03e4-4d99-98ac-79d4813d32c6.png",
[Instrumentation] Parsed count pre-model payload items: 10
flutter: ║                 "categoryId": 20,
flutter: ║                 "categoryName": "fouad",
flutter: ║                 "subcategoryId": 1004,
flutter: ║                 "subcategoryName": "ghanim",
flutter: ║                 "governorate": "كفر السيخ",
[HTTP] HTTP GET /api/Product -> 200
       responseType=_Map<String, dynamic>
       responseBody={items: [{id: 8, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 2, categoryName: Sportsfdfa, subcategoryId: 202, subcategoryName: City Bikes, locationArea: Dokki, rejectReason: null, city: , governorate: , condition: 2, productType: Sports, brand: Galaxy, insuranceAmount: 0.0, name: City Bike, description: Comfortable city bicycle, basePricePerDay: 0, finalPricePerDay: 70.0, commissionPercentage: 0, termsConditions: Return clean, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 3, totalReviews: 1, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 9, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 3, categoryName: Cameras, subcategoryId: 301, subcategoryName: DSLR, locationArea: Nasr City, rejectReason: null, city: , governorate: , condition: Used, productType: Electronics, brand: Canon, insuranceAmount: 0.0, name: Canon DSLR Camera, description: Canon DSLR with lens, basePricePerDay: 0, finalPricePerDay: 150.0, commissionPercentage: 0, termsConditions: No scratches, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 4, totalReviews: 1, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 10, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 3, categoryName: Cameras, subcategoryId: 302, subcategoryName: Other, locationArea: Helwan, rejectReason: null, city: , governorate: , condition: 2, productType: Electronics, brand: Nikon, insuranceAmount: 0.0, name: Nikon Camera, description: Nikon camera with tripod, basePricePerDay: 0, finalPricePerDay: 140.0, commissionPercentage: 0, termsConditions: Handle carefully, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 5, totalReviews: 1, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 11, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 4, categoryName: Computers, subcategoryId: 401, subcategoryName: Laptops, locationArea: Zamalek, rejectReason: null, city: , governorate: , condition: Used, productType: Computers, brand: Dell, insuranceAmount: 0.0, name: Dell Laptop, description: Core i7 laptop 16GB RAM, basePricePerDay: 0, finalPricePerDay: 220.0, commissionPercentage: 0, termsConditions: No software install, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 13, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 5, categoryName: Projectors, subcategoryId: 501, subcategoryName: HD Projectors, locationArea: Maadi, rejectReason: null, city: , governorate: , condition: Used, productType: Projectors, brand: Epson, insuranceAmount: 0.0, name: Epson Projector, description: Full HD projector, basePricePerDay: 0, finalPricePerDay: 130.0, commissionPercentage: 0, termsConditions: Indoor use only, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 14, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 5, categoryName: Projectors, subcategoryId: 502, subcategoryName: Portable Projectors, locationArea: Dokki, rejectReason: null, city: , governorate: , condition: 2, productType: Projectors, brand: BenQ, insuranceAmount: 0.0, name: BenQ Projector, description: Portable projector, basePricePerDay: 0, finalPricePerDay: 120.0, commissionPercentage: 0, termsConditions: No dropping, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 15, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 6, categoryName: Tools, subcategoryId: 601, subcategoryName: Drills, locationArea: Heliopolis, rejectReason: null, city: , governorate: , condition: Used, productType: Tools, brand: Bosch, insuranceAmount: 0.0, name: Electric Drill, description: Bosch heavy-duty drill, basePricePerDay: 0, finalPricePerDay: 60.0, commissionPercentage: 0, termsConditions: Return with case, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 16, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 6, categoryName: Tools, subcategoryId: 602, subcategoryName: Grinders, locationArea: Nasr City, rejectReason: null, city: , governorate: , condition: 2, productType: Tools, brand: Makita, insuranceAmount: 0.0, name: Angle Grinder, description: Makita grinder, basePricePerDay: 0, finalPricePerDay: 55.0, commissionPercentage: 0, termsConditions: Safety required, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 17, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 7, categoryName: Gaming, subcategoryId: 701, subcategoryName: Steering Wheels, locationArea: Maadi, rejectReason: null, city: , governorate: , condition: Used, productType: Gaming, brand: Logitech, insuranceAmount: 0.0, name: Gaming Steering Wheel, description: Wheel for racing games, basePricePerDay: 0, finalPricePerDay: 80.0, commissionPercentage: 0, termsConditions: Return intact, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 18, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 7, categoryName: Gaming, subcategoryId: 702, subcategoryName: Keyboards, locationArea: Dokki, rejectReason: null, city: , governorate: , condition: 2, productType: Gaming, brand: Razer, insuranceAmount: 0.0, name: Gaming Keyboard, description: RGB mechanical keyboard, basePricePerDay: 0, finalPricePerDay: 40.0, commissionPercentage: 0, termsConditions: No liquid damage, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}], totalCount: 22, pageNumber: 1, pageSize: 10, totalPages: 3, hasPrevious: false, hasNext: true}
flutter: ║                 "city": "كفر الشيخ",
flutter: ║                 "address": "طريق كفر الشيخ, طنطا, كفر الشيخ, 33717, مصر",
flutter: ║                 "title": "فستان نبيتي",
[Instrumentation] Parsed count post-model: 10
[Instrumentation] Repository count success: 10
flutter: ║                 "budget": 600.0,
[Instrumentation] PagingController count success: 10
[Instrumentation] Cubit state transition: ProductLoading -> ProductLoaded
[Instrumentation] Cubit count: 10
flutter: ║                 "startDate": "2026-06-12T00:00:00",
flutter: ║                 "endDate": "2026-06-20T00:00:00",
flutter: ║                 "description": "عايزه فسان سواريه ينفع خطوبه يكون صك ",
flutter: ║                 "imageUrl": "/uploads/community/0126e442-e1e3-46ff-8cb5-9eb425425ca9.png",
flutter: ║                 "status": "Approved",
flutter: ║                 "rejectionReason": null,
flutter: ║                 "createdAt": "2026-06-06T16:58:06.3166838",
flutter: ║                 "offersCount": 0
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 2,
flutter: ║                 "userId": "83e358a2-997c-4478-a698-380fb6f02353",
flutter: ║                 "userName": "fouad",
flutter: ║                 "userImage": "/uploads/idcards/83d68dd1-03e4-4d99-98ac-79d4813d32c6.png",
flutter: ║                 "categoryId": 1,
flutter: ║                 "categoryName": "Electronics",
flutter: ║                 "subcategoryId": 102,
flutter: ║                 "subcategoryName": "Xbox",
flutter: ║                 "governorate": "سخا",
flutter: ║                 "city": "كفر الشيخ",
flutter: ║                 "address": "طريق كفر الشيخ, طنطا, كفر الشيخ, 33717, مصر",
flutter: ║                 "title": "test",
flutter: ║                 "budget": 44.0,
flutter: ║                 "startDate": "2026-06-06T00:00:00",
flutter: ║                 "endDate": "2026-06-08T00:00:00",
flutter: ║                 "description": "hello world",
flutter: ║                 "imageUrl": "/uploads/community/635d5460-d4aa-4867-8b7e-c55fb375669b.png",
flutter: ║                 "status": "Approved",
flutter: ║                 "rejectionReason": null,
flutter: ║                 "createdAt": "2026-06-06T16:47:07.1015343",
flutter: ║                 "offersCount": 0
flutter: ║            }
flutter: ║         ],
flutter: ║         "totalCount": 6,
flutter: ║         "pageNumber": 1,
flutter: ║         "pageSize": 10,
flutter: ║         "totalPages": 1,
flutter: ║         "hasPrevious": false,
flutter: ║         "hasNext": false
flutter: ║    }
flutter: ║
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Response ║ GET ║ Status: 200 OK  ║ Time: 442 ms
flutter: ║  https://rentalplatform.runasp.net/api/Product?pageNumber=1&pageSize=10
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Body
flutter: ║
flutter: ║    {
flutter: ║         "items": [
flutter: ║            {
flutter: ║                 "id": 8,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 2,
flutter: ║                 "categoryName": "Sportsfdfa",
flutter: ║                 "subcategoryId": 202,
flutter: ║                 "subcategoryName": "City Bikes",
flutter: ║                 "locationArea": "Dokki",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "2",
flutter: ║                 "productType": "Sports",
flutter: ║                 "brand": "Galaxy",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "City Bike",
flutter: ║                 "description": "Comfortable city bicycle",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 70.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "Return clean",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 3,
flutter: ║                 "totalReviews": 1,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 9,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 3,
flutter: ║                 "categoryName": "Cameras",
flutter: ║                 "subcategoryId": 301,
flutter: ║                 "subcategoryName": "DSLR",
flutter: ║                 "locationArea": "Nasr City",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "Used",
flutter: ║                 "productType": "Electronics",
flutter: ║                 "brand": "Canon",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Canon DSLR Camera",
flutter: ║                 "description": "Canon DSLR with lens",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 150.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "No scratches",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 4,
flutter: ║                 "totalReviews": 1,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 10,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 3,
flutter: ║                 "categoryName": "Cameras",
flutter: ║                 "subcategoryId": 302,
flutter: ║                 "subcategoryName": "Other",
flutter: ║                 "locationArea": "Helwan",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "2",
flutter: ║                 "productType": "Electronics",
flutter: ║                 "brand": "Nikon",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Nikon Camera",
flutter: ║                 "description": "Nikon camera with tripod",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 140.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "Handle carefully",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 5,
flutter: ║                 "totalReviews": 1,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 11,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 4,
flutter: ║                 "categoryName": "Computers",
flutter: ║                 "subcategoryId": 401,
flutter: ║                 "subcategoryName": "Laptops",
flutter: ║                 "locationArea": "Zamalek",
flutter: ║                 "rejectReason": null,
[Instrumentation] itemBuilder count: Index 0, Item: 8
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "Used",
flutter: ║                 "productType": "Computers",
flutter: ║                 "brand": "Dell",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Dell Laptop",
flutter: ║                 "description": "Core i7 laptop 16GB RAM",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 220.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "No software install",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 13,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 5,
flutter: ║                 "categoryName": "Projectors",
flutter: ║                 "subcategoryId": 501,
flutter: ║                 "subcategoryName": "HD Projectors",
flutter: ║                 "locationArea": "Maadi",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "Used",
flutter: ║                 "productType": "Projectors",
flutter: ║                 "brand": "Epson",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Epson Projector",
flutter: ║                 "description": "Full HD projector",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 130.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "Indoor use only",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
[Instrumentation] itemBuilder count: Index 1, Item: 9
flutter: ║            {
flutter: ║                 "id": 14,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 5,
flutter: ║                 "categoryName": "Projectors",
flutter: ║                 "subcategoryId": 502,
flutter: ║                 "subcategoryName": "Portable Projectors",
flutter: ║                 "locationArea": "Dokki",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "2",
flutter: ║                 "productType": "Projectors",
flutter: ║                 "brand": "BenQ",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "BenQ Projector",
flutter: ║                 "description": "Portable projector",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 120.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "No dropping",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 15,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 6,
flutter: ║                 "categoryName": "Tools",
flutter: ║                 "subcategoryId": 601,
flutter: ║                 "subcategoryName": "Drills",
flutter: ║                 "locationArea": "Heliopolis",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "Used",
flutter: ║                 "productType": "Tools",
flutter: ║                 "brand": "Bosch",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Electric Drill",
flutter: ║                 "description": "Bosch heavy-duty drill",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 60.0,
[Instrumentation] itemBuilder count: Index 2, Item: 10
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "Return with case",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 16,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 6,
flutter: ║                 "categoryName": "Tools",
flutter: ║                 "subcategoryId": 602,
flutter: ║                 "subcategoryName": "Grinders",
flutter: ║                 "locationArea": "Nasr City",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "2",
flutter: ║                 "productType": "Tools",
flutter: ║                 "brand": "Makita",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Angle Grinder",
flutter: ║                 "description": "Makita grinder",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 55.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "Safety required",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 17,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 7,
flutter: ║                 "categoryName": "Gaming",
flutter: ║                 "subcategoryId": 701,
flutter: ║                 "subcategoryName": "Steering Wheels",
flutter: ║                 "locationArea": "Maadi",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "Used",
flutter: ║                 "productType": "Gaming",
flutter: ║                 "brand": "Logitech",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Gaming Steering Wheel",
flutter: ║                 "description": "Wheel for racing games",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 80.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "Return intact",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 18,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 7,
flutter: ║                 "categoryName": "Gaming",
flutter: ║                 "subcategoryId": 702,
flutter: ║                 "subcategoryName": "Keyboards",
flutter: ║                 "locationArea": "Dokki",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "2",
flutter: ║                 "productType": "Gaming",
flutter: ║                 "brand": "Razer",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Gaming Keyboard",
flutter: ║                 "description": "RGB mechanical keyboard",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 40.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "No liquid damage",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            }
flutter: ║         ],
flutter: ║         "totalCount": 22,
flutter: ║         "pageNumber": 1,
flutter: ║         "pageSize": 10,
flutter: ║         "totalPages": 3,
flutter: ║         "hasPrevious": false,
flutter: ║         "hasNext": true
flutter: ║    }
flutter: ║
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
[HTTP] HTTP GET /api/Community/my-offers -> 200
       responseType=List<dynamic>
       responseBody=[]
flutter:
flutter: ╔╣ Response ║ GET ║ Status: 200 OK  ║ Time: 549 ms
flutter: ║  https://rentalplatform.runasp.net/api/Community/my-offers
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Body
flutter: ║
flutter: ║    [
flutter: ║    ]
flutter: ║
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Response ║ GET ║ Status: 200 OK  ║ Time: 577 ms
flutter: ║  https://rentalplatform.runasp.net/api/UserDashboard/subscription
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
[HTTP] HTTP GET /api/UserDashboard/subscription -> 200
       responseType=_Map<String, dynamic>
       responseBody={subscriptionName: string, maxProducts: 7062, usedProducts: 1, productsPercentage: 0, expiryDate: 2026-06-22T07:34:21.0391153}
[Subscription] SubscriptionRemoteDataSourceImpl.getActiveSubscription: response status=200
               response body={subscriptionName: string, maxProducts: 7062, usedProducts: 1, productsPercentage: 0, expiryDate: 2026-06-22T07:34:21.0391153}
[Subscription] SubscriptionRemoteDataSourceImpl.getActiveSubscription: success on attempt 1
               payload={subscriptionName: string, maxProducts: 7062, usedProducts: 1, productsPercentage: 0, expiryDate: 2026-06-22T07:34:21.0391153}
flutter: ╔ Body
flutter: ║
flutter: ║    {
flutter: ║         "subscriptionName": "string",
flutter: ║         "maxProducts": 7062,
flutter: ║         "usedProducts": 1,
flutter: ║         "productsPercentage": 0,
flutter: ║         "expiryDate": "2026-06-22T07:34:21.0391153"
flutter: ║    }
flutter: ║
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Response ║ GET ║ Status: 200 OK  ║ Time: 837 ms
flutter: ║  https://rentalplatform.runasp.net/api/Categories?PageNumber=1&PageSize=100
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Body
flutter: ║
flutter: ║    {
flutter: ║         "items": [
flutter: ║          {id: 1, name: Electronics, imageUrl: null, createdAt: 2026-04-07T14:47:35.95},
flutter: ║          {id: 2, name: Sportsfdfa, imageUrl: null, createdAt: 2026-04-07T14:47:36.0466667},
flutter: ║          {id: 3, name: Cameras, imageUrl: null, createdAt: 2026-04-07T14:47:36.2033333},
flutter: ║          {id: 4, name: Computers, imageUrl: null, createdAt: 2026-04-07T14:47:36.3},
flutter: ║          {id: 5, name: Projectors, imageUrl: null, createdAt: 2026-04-07T14:47:36.4566667},
flutter: ║          {id: 6, name: Tools, imageUrl: null, createdAt: 2026-04-07T14:47:36.6566667},
flutter: ║          {id: 7, name: Gaming, imageUrl: null, createdAt: 2026-04-07T14:47:36.7566667},
flutter: ║          {id: 8, name: Audio, imageUrl: null, createdAt: 2026-04-07T14:47:36.8566667},
flutter: ║          {id: 9, name: Photography, imageUrl: null, createdAt: 2026-04-07T14:47:36.9366667},
flutter: ║          {id: 10, name: Furniture, imageUrl: null, createdAt: 2026-04-07T14:47:37.0333333},
flutter: ║          {id: 12, name: Alex, imageUrl: null, createdAt: 2026-04-08T12:59:41.3153105},
flutter: ║          {id: 15, name: test, imageUrl: null, createdAt: 2026-05-13T18:11:13.1279372},
flutter: ║          {id: 18, name: Rawan selima, imageUrl: null, createdAt: 2026-05-13T20:23:05.394277},
flutter: ║          {id: 19, name: Rawan, imageUrl: null, createdAt: 2026-05-13T20:43:35.7703289},
flutter: ║          {id: 20, name: fouad, imageUrl: null, createdAt: 2026-05-15T14:42:05.3871564},
flutter: ║          {id: 21, name: صوره, imageUrl: null, createdAt: 2026-05-18T01:34:09.8971229},
flutter: ║          {id: 22, name: اختبار, imageUrl: null, createdAt: 2026-05-18T01:36:05.0290199},
flutter: ║          {id: 23, name: clothes, imageUrl: null, createdAt: 2026-05-18T01:40:27.7866075}
flutter: ║         ],
flutter: ║         "totalCount": 18,
flutter: ║         "pageNumber": 1,
flutter: ║         "pageSize": 50,
flutter: ║         "totalPages": 1,
flutter: ║         "hasPrevious": false,
flutter: ║         "hasNext": false
flutter: ║    }
flutter: ║
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
[HTTP] HTTP GET /api/Categories -> 200
       responseType=_Map<String, dynamic>
       responseBody={items: [{id: 1, name: Electronics, imageUrl: null, createdAt: 2026-04-07T14:47:35.95}, {id: 2, name: Sportsfdfa, imageUrl: null, createdAt: 2026-04-07T14:47:36.0466667}, {id: 3, name: Cameras, imageUrl: null, createdAt: 2026-04-07T14:47:36.2033333}, {id: 4, name: Computers, imageUrl: null, createdAt: 2026-04-07T14:47:36.3}, {id: 5, name: Projectors, imageUrl: null, createdAt: 2026-04-07T14:47:36.4566667}, {id: 6, name: Tools, imageUrl: null, createdAt: 2026-04-07T14:47:36.6566667}, {id: 7, name: Gaming, imageUrl: null, createdAt: 2026-04-07T14:47:36.7566667}, {id: 8, name: Audio, imageUrl: null, createdAt: 2026-04-07T14:47:36.8566667}, {id: 9, name: Photography, imageUrl: null, createdAt: 2026-04-07T14:47:36.9366667}, {id: 10, name: Furniture, imageUrl: null, createdAt: 2026-04-07T14:47:37.0333333}, {id: 12, name: Alex, imageUrl: null, createdAt: 2026-04-08T12:59:41.3153105}, {id: 15, name: test, imageUrl: null, createdAt: 2026-05-13T18:11:13.1279372}, {id: 18, name: Rawan selima, imageUrl: null, createdAt: 2026-05-13T20:23:05.394277}, {id: 19, name: Rawan, imageUrl: null, createdAt: 2026-05-13T20:43:35.7703289}, {id: 20, name: fouad, imageUrl: null, createdAt: 2026-05-15T14:42:05.3871564}, {id: 21, name: صوره, imageUrl: null, createdAt: 2026-05-18T01:34:09.8971229}, {id: 22, name: اختبار, imageUrl: null, createdAt: 2026-05-18T01:36:05.0290199}, {id: 23, name: clothes, imageUrl: null, createdAt: 2026-05-18T01:40:27.7866075}], totalCount: 18, pageNumber: 1, pageSize: 50, totalPages: 1, hasPrevious: false, hasNext: false}
flutter:
flutter: ╔╣ Response ║ GET ║ Status: 200 OK  ║ Time: 863 ms
flutter: ║  https://rentalplatform.runasp.net/api/Chat/conversations
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Body
flutter: ║
flutter: ║    [
flutter: ║        {
flutter: ║             "id": 5,
flutter: ║             "otherUserId": "e34a1b6e-434d-44e2-83b6-6b3f27536db4",
flutter: ║             "otherUserName": "Ali",
flutter: ║             "otherUserImage": "/uploads/idcards/61bf5e08-afc6-4ca3-ad15-eb77501b1214.jpg",
[HTTP] HTTP GET /api/Chat/conversations -> 200
       responseType=List<dynamic>
       responseBody=[{id: 5, otherUserId: e34a1b6e-434d-44e2-83b6-6b3f27536db4, otherUserName: Ali, otherUserImage: /uploads/idcards/61bf5e08-afc6-4ca3-ad15-eb77501b1214.jpg, lastMessagePreview: السلام عليكم, lastMessageAt: 2026-06-02T15:43:12.1663825, unreadCount: 0}, {id: 4, otherUserId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, otherUserName: Test User, otherUserImage: dummy_image.jpg, lastMessagePreview: هل المنتج متاح الان؟, lastMessageAt: 2026-06-02T15:41:39.6332375, unreadCount: 0}]
flutter: ║             "lastMessagePreview": "السلام عليكم",
flutter: ║             "lastMessageAt": "2026-06-02T15:43:12.1663825",
flutter: ║             "unreadCount": 0
flutter: ║        },
flutter: ║        {
flutter: ║             "id": 4,
flutter: ║             "otherUserId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║             "otherUserName": "Test User",
flutter: ║             "otherUserImage": "dummy_image.jpg",
flutter: ║             "lastMessagePreview": "هل المنتج متاح الان؟",
flutter: ║             "lastMessageAt": "2026-06-02T15:41:39.6332375",
flutter: ║             "unreadCount": 0
flutter: ║        }
flutter: ║    ]
flutter: ║
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter:
flutter: ╔╣ Response ║ GET ║ Status: 200 OK  ║ Time: 896 ms
flutter: ║  https://rentalplatform.runasp.net/api/Product?pageNumber=1&pageSize=10
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
flutter: ╔ Body
flutter: ║
flutter: ║    {
flutter: ║         "items": [
flutter: ║            {
flutter: ║                 "id": 8,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 2,
flutter: ║                 "categoryName": "Sportsfdfa",
flutter: ║                 "subcategoryId": 202,
flutter: ║                 "subcategoryName": "City Bikes",
flutter: ║                 "locationArea": "Dokki",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "2",
flutter: ║                 "productType": "Sports",
flutter: ║                 "brand": "Galaxy",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "City Bike",
flutter: ║                 "description": "Comfortable city bicycle",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 70.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "Return clean",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 3,
flutter: ║                 "totalReviews": 1,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 9,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 3,
flutter: ║                 "categoryName": "Cameras",
flutter: ║                 "subcategoryId": 301,
flutter: ║                 "subcategoryName": "DSLR",
flutter: ║                 "locationArea": "Nasr City",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "Used",
flutter: ║                 "productType": "Electronics",
flutter: ║                 "brand": "Canon",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Canon DSLR Camera",
flutter: ║                 "description": "Canon DSLR with lens",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 150.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "No scratches",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 4,
[Instrumentation] Parsed count pre-model payload items: 10
flutter: ║                 "totalReviews": 1,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
[Instrumentation] Parsed count post-model: 10
flutter: ║                 "images": []
[Instrumentation] Repository count success: 10
[Instrumentation] PagingController count success: 10
[Instrumentation] Cubit state transition: ProductLoaded -> ProductLoaded
[Instrumentation] Cubit count: 10
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 10,
[HTTP] HTTP GET /api/Product -> 200
       responseType=_Map<String, dynamic>
       responseBody={items: [{id: 8, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 2, categoryName: Sportsfdfa, subcategoryId: 202, subcategoryName: City Bikes, locationArea: Dokki, rejectReason: null, city: , governorate: , condition: 2, productType: Sports, brand: Galaxy, insuranceAmount: 0.0, name: City Bike, description: Comfortable city bicycle, basePricePerDay: 0, finalPricePerDay: 70.0, commissionPercentage: 0, termsConditions: Return clean, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 3, totalReviews: 1, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 9, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 3, categoryName: Cameras, subcategoryId: 301, subcategoryName: DSLR, locationArea: Nasr City, rejectReason: null, city: , governorate: , condition: Used, productType: Electronics, brand: Canon, insuranceAmount: 0.0, name: Canon DSLR Camera, description: Canon DSLR with lens, basePricePerDay: 0, finalPricePerDay: 150.0, commissionPercentage: 0, termsConditions: No scratches, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 4, totalReviews: 1, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 10, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 3, categoryName: Cameras, subcategoryId: 302, subcategoryName: Other, locationArea: Helwan, rejectReason: null, city: , governorate: , condition: 2, productType: Electronics, brand: Nikon, insuranceAmount: 0.0, name: Nikon Camera, description: Nikon camera with tripod, basePricePerDay: 0, finalPricePerDay: 140.0, commissionPercentage: 0, termsConditions: Handle carefully, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 5, totalReviews: 1, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 11, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 4, categoryName: Computers, subcategoryId: 401, subcategoryName: Laptops, locationArea: Zamalek, rejectReason: null, city: , governorate: , condition: Used, productType: Computers, brand: Dell, insuranceAmount: 0.0, name: Dell Laptop, description: Core i7 laptop 16GB RAM, basePricePerDay: 0, finalPricePerDay: 220.0, commissionPercentage: 0, termsConditions: No software install, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 13, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 5, categoryName: Projectors, subcategoryId: 501, subcategoryName: HD Projectors, locationArea: Maadi, rejectReason: null, city: , governorate: , condition: Used, productType: Projectors, brand: Epson, insuranceAmount: 0.0, name: Epson Projector, description: Full HD projector, basePricePerDay: 0, finalPricePerDay: 130.0, commissionPercentage: 0, termsConditions: Indoor use only, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 14, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 5, categoryName: Projectors, subcategoryId: 502, subcategoryName: Portable Projectors, locationArea: Dokki, rejectReason: null, city: , governorate: , condition: 2, productType: Projectors, brand: BenQ, insuranceAmount: 0.0, name: BenQ Projector, description: Portable projector, basePricePerDay: 0, finalPricePerDay: 120.0, commissionPercentage: 0, termsConditions: No dropping, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 15, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 6, categoryName: Tools, subcategoryId: 601, subcategoryName: Drills, locationArea: Heliopolis, rejectReason: null, city: , governorate: , condition: Used, productType: Tools, brand: Bosch, insuranceAmount: 0.0, name: Electric Drill, description: Bosch heavy-duty drill, basePricePerDay: 0, finalPricePerDay: 60.0, commissionPercentage: 0, termsConditions: Return with case, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 16, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 6, categoryName: Tools, subcategoryId: 602, subcategoryName: Grinders, locationArea: Nasr City, rejectReason: null, city: , governorate: , condition: 2, productType: Tools, brand: Makita, insuranceAmount: 0.0, name: Angle Grinder, description: Makita grinder, basePricePerDay: 0, finalPricePerDay: 55.0, commissionPercentage: 0, termsConditions: Safety required, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 17, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 7, categoryName: Gaming, subcategoryId: 701, subcategoryName: Steering Wheels, locationArea: Maadi, rejectReason: null, city: , governorate: , condition: Used, productType: Gaming, brand: Logitech, insuranceAmount: 0.0, name: Gaming Steering Wheel, description: Wheel for racing games, basePricePerDay: 0, finalPricePerDay: 80.0, commissionPercentage: 0, termsConditions: Return intact, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}, {id: 18, userId: 8b0c078d-f802-4b7d-a8db-88cf2410a6cf, userFullName: Test User, categoryId: 7, categoryName: Gaming, subcategoryId: 702, subcategoryName: Keyboards, locationArea: Dokki, rejectReason: null, city: , governorate: , condition: 2, productType: Gaming, brand: Razer, insuranceAmount: 0.0, name: Gaming Keyboard, description: RGB mechanical keyboard, basePricePerDay: 0, finalPricePerDay: 40.0, commissionPercentage: 0, termsConditions: No liquid damage, status: Approved, createdAt: 2026-04-07T14:47:41.552038, averageRating: 0, totalReviews: 0, totalRentalCount: 0, totalPlatformProfit: 0, images: []}], totalCount: 22, pageNumber: 1, pageSize: 10, totalPages: 3, hasPrevious: false, hasNext: true}
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 3,
flutter: ║                 "categoryName": "Cameras",
flutter: ║                 "subcategoryId": 302,
flutter: ║                 "subcategoryName": "Other",
flutter: ║                 "locationArea": "Helwan",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "2",
[Instrumentation] itemBuilder count: Index 0, Item: 8
flutter: ║                 "productType": "Electronics",
flutter: ║                 "brand": "Nikon",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Nikon Camera",
flutter: ║                 "description": "Nikon camera with tripod",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 140.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "Handle carefully",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 5,
flutter: ║                 "totalReviews": 1,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 11,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
[Instrumentation] itemBuilder count: Index 1, Item: 9
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 4,
flutter: ║                 "categoryName": "Computers",
flutter: ║                 "subcategoryId": 401,
flutter: ║                 "subcategoryName": "Laptops",
flutter: ║                 "locationArea": "Zamalek",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "Used",
flutter: ║                 "productType": "Computers",
flutter: ║                 "brand": "Dell",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Dell Laptop",
flutter: ║                 "description": "Core i7 laptop 16GB RAM",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 220.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "No software install",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
[Instrumentation] itemBuilder count: Index 2, Item: 10
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 13,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 5,
flutter: ║                 "categoryName": "Projectors",
flutter: ║                 "subcategoryId": 501,
flutter: ║                 "subcategoryName": "HD Projectors",
flutter: ║                 "locationArea": "Maadi",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "Used",
flutter: ║                 "productType": "Projectors",
flutter: ║                 "brand": "Epson",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Epson Projector",
flutter: ║                 "description": "Full HD projector",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 130.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "Indoor use only",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 14,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 5,
flutter: ║                 "categoryName": "Projectors",
flutter: ║                 "subcategoryId": 502,
flutter: ║                 "subcategoryName": "Portable Projectors",
flutter: ║                 "locationArea": "Dokki",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "2",
flutter: ║                 "productType": "Projectors",
flutter: ║                 "brand": "BenQ",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "BenQ Projector",
flutter: ║                 "description": "Portable projector",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 120.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "No dropping",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 15,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 6,
flutter: ║                 "categoryName": "Tools",
flutter: ║                 "subcategoryId": 601,
flutter: ║                 "subcategoryName": "Drills",
flutter: ║                 "locationArea": "Heliopolis",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "Used",
flutter: ║                 "productType": "Tools",
flutter: ║                 "brand": "Bosch",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Electric Drill",
flutter: ║                 "description": "Bosch heavy-duty drill",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 60.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "Return with case",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 16,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 6,
flutter: ║                 "categoryName": "Tools",
flutter: ║                 "subcategoryId": 602,
flutter: ║                 "subcategoryName": "Grinders",
flutter: ║                 "locationArea": "Nasr City",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "2",
flutter: ║                 "productType": "Tools",
flutter: ║                 "brand": "Makita",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Angle Grinder",
flutter: ║                 "description": "Makita grinder",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 55.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "Safety required",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 17,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 7,
flutter: ║                 "categoryName": "Gaming",
flutter: ║                 "subcategoryId": 701,
flutter: ║                 "subcategoryName": "Steering Wheels",
flutter: ║                 "locationArea": "Maadi",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "Used",
flutter: ║                 "productType": "Gaming",
flutter: ║                 "brand": "Logitech",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Gaming Steering Wheel",
flutter: ║                 "description": "Wheel for racing games",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 80.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "Return intact",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            },
flutter: ║            {
flutter: ║                 "id": 18,
flutter: ║                 "userId": "8b0c078d-f802-4b7d-a8db-88cf2410a6cf",
flutter: ║                 "userFullName": "Test User",
flutter: ║                 "categoryId": 7,
flutter: ║                 "categoryName": "Gaming",
flutter: ║                 "subcategoryId": 702,
flutter: ║                 "subcategoryName": "Keyboards",
flutter: ║                 "locationArea": "Dokki",
flutter: ║                 "rejectReason": null,
flutter: ║                 "city": "",
flutter: ║                 "governorate": "",
flutter: ║                 "condition": "2",
flutter: ║                 "productType": "Gaming",
flutter: ║                 "brand": "Razer",
flutter: ║                 "insuranceAmount": 0.0,
flutter: ║                 "name": "Gaming Keyboard",
flutter: ║                 "description": "RGB mechanical keyboard",
flutter: ║                 "basePricePerDay": 0,
flutter: ║                 "finalPricePerDay": 40.0,
flutter: ║                 "commissionPercentage": 0,
flutter: ║                 "termsConditions": "No liquid damage",
flutter: ║                 "status": "Approved",
flutter: ║                 "createdAt": "2026-04-07T14:47:41.552038",
flutter: ║                 "averageRating": 0,
flutter: ║                 "totalReviews": 0,
flutter: ║                 "totalRentalCount": 0,
flutter: ║                 "totalPlatformProfit": 0,
flutter: ║                 "images": []
flutter: ║            }
flutter: ║         ],
flutter: ║         "totalCount": 22,
flutter: ║         "pageNumber": 1,
flutter: ║         "pageSize": 10,
flutter: ║         "totalPages": 3,
flutter: ║         "hasPrevious": false,
flutter: ║         "hasNext": true
flutter: ║    }
flutter: ║
flutter: ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
[Instrumentation] itemBuilder count: Index 0, Item: 8
[Instrumentation] itemBuilder count: Index 1, Item: 9
[Instrumentation] itemBuilder count: Index 2, Item: 10
[Instrumentation] itemBuilder count: Index 0, Item: 8
[Instrumentation] itemBuilder count: Index 1, Item: 9
[Instrumentation] itemBuilder count: Index 2, Item: 10

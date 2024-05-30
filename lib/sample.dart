// Openapi Generator last run: : 2024-05-27T22:49:30.395225
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties:
        DioProperties(pubName: 'petstore_api', pubAuthor: 'Johnny dep..'),
    inputSpec:
        RemoteSpec(path: 'https://petstore3.swagger.io/api/v3/openapi.json'),
    generatorName: Generator.dart,
    outputDirectory: 'api/petstore_api',
    skipSpecValidation: true,
    debugLogging: true)
class Example {}
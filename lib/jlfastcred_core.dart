library jlfastcred_core;

export 'src/constants/local_storage_constants.dart';
export 'src/exceptions/service_exception.dart';
export 'src/fp/either.dart';
export 'src/helpers/messages.dart';

//Model
export 'src/model/banking_information.dart';
export 'src/model/client.dart';
export 'src/model/referral.dart';
export 'src/model/simulation_model.dart';
export 'src/model/urls.dart';
export 'src/model/users.dart';
export 'src/model/advance.dart';
//Model | BRASIL API
export 'src/model/brasilapi/cep_v1.dart';
export 'src/model/brasilapi/bank_details.dart';

//REPOSITORY
export 'src/repositories/user/user_repository.dart';
export 'src/repositories/user/user_repository_impl.dart';
export 'src/repositories/simulation/simulation_repository.dart';
export 'src/repositories/simulation/simulation_repository_impl.dart';
export 'src/repositories/advance/advance_repository.dart';
export 'src/repositories/advance/advance_repository_impl.dart';
export 'src/repositories/client/client_repository.dart';
export 'src/repositories/client/client_repository_impl.dart';
//REPOSITORY | BRASIL API
export 'src/repositories/brasilapi/brasil_api_repository.dart';
export 'src/repositories/brasilapi/brasil_api_repository_impl.dart';

//SERVICE
export 'src/services/user_login_service.dart';
export 'src/services/user_login_service_impl.dart';
export 'src/services/simulation_service.dart';
export 'src/services/simulation_service_impl.dart';
export 'src/services/user_service.dart';
export 'src/services/user_service_impl.dart';
export 'src/services/advance_service.dart';
export 'src/services/advance_service_impl.dart';
export 'src/services/client_service.dart';
export 'src/services/client_service_impl.dart';
//SERVICE | BRASIL API
export 'src/services/brasilapi/brasil_api_service.dart';
export 'src/services/brasilapi/brasil_api_service_impl.dart';

//Theme
export 'src/theme/jlfastcred_theme.dart';

//Widger
export 'src/widgets/jlfastcred_app_bar.dart';
export 'src/widgets/icon_popup_menu_widget.dart';
export 'src/widgets/icon_button_widget.dart';
export 'src/widgets/simulation_card_widget.dart';
export 'src/widgets/file_selector.dart';
export 'src/widgets/document_box_widget.dart';
export 'src/widgets/client_card_widget.dart';
export 'src/widgets/header_widget.dart';
export 'src/widgets/custom_text_field.dart';

//config
export 'src/jlfastcred_core_config.dart';

//constants
export 'src/constants//app_labels.dart';

export 'src/restClient/rest_client.dart'
    if (dart.library.html) 'src/restClient/rest_client_web.dart';

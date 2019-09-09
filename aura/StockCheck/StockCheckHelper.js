/**
 * Created by Eugene on 08.09.2019.
 */
({
    callAction : function(action, params, successCallback) {
        if (action) {
            console.log('HELPER params', params);
            action.setParams(params);
            action.setCallback(this, function(response) {
                var state = response.getState();
                console.log('HELPER state', state);
                if (state === "SUCCESS") {
                    successCallback(response);
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    var message = 'Unknown error'; // Default error message
                    // Retrieve the error message sent by the server
                    if (errors && Array.isArray(errors) && errors.length > 0) {
                        message = errors[0].message;
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title: 'Error',
                            type: 'error',
                            message: message
                        });
                        toastEvent.fire();
                    }
                    console.error(message);
                }
            });
            $A.enqueueAction(action);
        }
    }
})
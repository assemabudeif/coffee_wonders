abstract class EgyptCartStates {}

class CartInitState extends EgyptCartStates {}

class IncrementProductCounterState extends EgyptCartStates {}

class DecrementProductCounterState extends EgyptCartStates {}

class CartLoadingState extends EgyptCartStates {}

class CartSuccessState extends EgyptCartStates {}

class CartErrorState extends EgyptCartStates {}

class EditCartLoadingState extends EgyptCartStates {}

class EditCartSuccessState extends EgyptCartStates {}

class EditCartErrorState extends EgyptCartStates {}


class CheckoutOrderLoadingState extends EgyptCartStates {}

class CheckoutOrderSuccessState extends EgyptCartStates {}

class CheckoutOrderErrorState extends EgyptCartStates {}

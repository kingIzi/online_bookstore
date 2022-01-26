//set object state
function setState(object,state){
    object.state = state
}

//change listview state (Navigation Bar)
function changeListViewState(_currentIndex,_homeFlick){
    switch (_currentIndex){
    case 0: //browse page
        setState(_homeFlick,"Home")
        break
    case 1: //favorites
        setState(_homeFlick,"Favorites")
        break
    case 2: //categories
        setState(_homeFlick,"Categories")
        break
    default:
        return
    }
}


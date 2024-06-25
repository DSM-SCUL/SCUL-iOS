import RxFlow

public enum SearchStep: Step {
    case searchIsRequired
    case placeGuideDetailIsRequired(cultureDetailId: String)
}

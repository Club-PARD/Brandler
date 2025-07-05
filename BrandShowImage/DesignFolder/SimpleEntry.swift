import WidgetKit

/// 위젯 타임라인에 표시할 데이터 구조체
struct SimpleEntry: TimelineEntry {
    /// 해당 데이터가 표시될 시점
    let date: Date
    
    /// 위젯 구성 인텐트 정보 (사용자가 설정한 값)
    let configuration: ConfigurationAppIntent
}

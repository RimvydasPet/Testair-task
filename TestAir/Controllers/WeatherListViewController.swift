import UIKit

class WeatherListViewController: UITableViewController {
   
    var weatherManager: WeatherManager!
    var weatherData: WeatherModel?
    var showHistory = false
    
    private var weatherHistoryItems: [WeatherModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WeatherTableViewCell.nib, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        loadHistoryItems()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    // TODO: Fetch history items from SwiftData here
    func loadHistoryItems() {
        guard showHistory else { return }
        weatherHistoryItems = [
            WeatherModel(cityName: "Vilnius", temperature: 20, icon: "", description: "Cloudy"),
            WeatherModel(cityName: "Vilnius", temperature: 20, icon: "", description: "Cloudy"),
            WeatherModel(cityName: "Vilnius", temperature: 20, icon: "", description: "Cloudy")
        ]
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showHistory ? weatherHistoryItems.count : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        
        if let weather = weatherData {
            print("Configuring cell with weather data: \(weather)")
            cell.cityLabel.text = weather.cityName
            cell.temperatureLabel.text = weather.temperatureString
            cell.descriptionLabel.text = weather.description
            cell.dateLabel.text = weather.formattedDate
            
            if let iconUrl = URL(string: weather.icon) {
                weatherManager.downloadImage(from: iconUrl) { image in
                    DispatchQueue.main.async {
                        cell.iconImageView.image = image
                    }
                }
            }
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}

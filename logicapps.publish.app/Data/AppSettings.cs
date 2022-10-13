namespace Logicapps.Publish.App;

public class AppSettings
{
    public string MySecret { get; set; }
    public string ApplicationInsightsKey { get; set; }
    public string PublishFunctionAppKey { get; set; }

    public AppSettings()
    {
        MySecret = string.Empty;
        ApplicationInsightsKey = string.Empty;
        PublishFunctionAppKey = string.Empty;
    }
    public AppSettings(string mySecret)
    {
        MySecret = string.IsNullOrEmpty(mySecret) ? string.Empty : mySecret;
        ApplicationInsightsKey = string.Empty;
        PublishFunctionAppKey = string.Empty;
    }
    public AppSettings(string mySecret, string applicationInsightsKey, string publishFunctionAppKey)
    {
        MySecret = string.IsNullOrEmpty(mySecret) ? string.Empty : mySecret;
        ApplicationInsightsKey = string.IsNullOrEmpty(applicationInsightsKey) ? string.Empty : applicationInsightsKey;
        PublishFunctionAppKey = string.IsNullOrEmpty(publishFunctionAppKey) ? string.Empty : publishFunctionAppKey;
    }
}

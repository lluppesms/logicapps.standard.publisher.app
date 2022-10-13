namespace Logicapps.Publish.App;

public class TestRepository
{
    #region Variables
    /// <summary>
    /// Application Settings
    /// </summary>
    public AppSettings settings { get; set; }
    #endregion

    #region Initialization
    /// <summary>
    /// Constructor
    /// </summary>
    public TestRepository()
    {
        // default the settings
        settings = new AppSettings();
    }

    /// <summary>
    /// Constructor
    /// </summary>
    public TestRepository(AppSettings diSettings)
    {
        settings = diSettings == null ? new AppSettings() : diSettings;
    }
    #endregion

    public string GetMySecret() {
        return settings.MySecret;
    }
}
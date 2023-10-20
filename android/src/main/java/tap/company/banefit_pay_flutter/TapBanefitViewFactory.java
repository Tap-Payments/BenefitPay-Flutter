package tap.company.banefit_pay_flutter;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;

import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import io.flutter.plugin.common.StandardMessageCodec;


public class TapBanefitViewFactory extends PlatformViewFactory {

    TapBanefitViewFactory() {
        super(StandardMessageCodec.INSTANCE);
    }
    @NonNull
    @Override
    public PlatformView create(Context context, int viewId, @Nullable Object args) {
        final Map<String, Object> creationParams = (Map<String, Object>) args;
        System.out.println("Configuration from example app >>>>>>>>>>" + creationParams);
        return new TapBanefitViewManager(context, viewId, creationParams);
    }
}

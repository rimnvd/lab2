package beans;

import java.io.Serializable;


public class ResponseBean implements Serializable {
    private final float x, y, r;
    private final String currentTime;
    private final String executionTime;
    private final String result;

    public ResponseBean(float x, float y, float r, String currentTime, String executionTime, String result) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.currentTime = currentTime;
        this.executionTime = executionTime;
        this.result = result;
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public float getR() {
        return r;
    }

    public String getCurrentTime() {
        return currentTime;
    }

    public String getExecutionTime() {
        return executionTime;
    }

    public String getResult() {
        return  result;
    }


}

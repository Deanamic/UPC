#include "modelInfo2.h"
#include "glwidget.h"


void ModelInfo2::onPluginLoad()
{
	
}

void ModelInfo2::preFrame()
{
	
}

void ModelInfo2::postFrame()
{
    int nobj, npol, nver, ntri;
	nobj = scene()->objects().size();
    npol = nver = ntri = 0;
    for(int i = 0; i < (int)scene()->objects().size(); ++i) {
        npol += scene()->objects()[i].faces().size();
        for(int j = 0; j < (int)scene()->objects()[i].faces().size(); ++j) {
            int fver = scene()->objects()[i].faces()[j].numVertices();
            nver += fver;
            if(fver == 3) ++ntri;
        }   
    }
    QFont font;
    font.setPixelSize(32);
    painter.begin(glwidget());
    painter.setFont(font);
    painter.setPen(QColor(0,0,0));
    int x = 15;
    int y = 40;
    QRectF Box(QPointF(x,y),QPointF(x+1000,y+1000));
    painter.drawText(Box, QString("Number of Objects:%1\nNumber of Polygons:%2\nNumber of Vertices:%3\nNumber of Triangles:%4").arg(nobj).arg(npol).arg(nver).arg(ntri));    
    painter.end();
}

void ModelInfo2::onObjectAdd()
{
	
}

bool ModelInfo2::drawScene()
{
	return false; // return true only if implemented
}

bool ModelInfo2::drawObject(int)
{
	return false; // return true only if implemented
}

bool ModelInfo2::paintGL()
{
	return false; // return true only if implemented
}

void ModelInfo2::keyPressEvent(QKeyEvent *)
{
	
}

void ModelInfo2::mouseMoveEvent(QMouseEvent *)
{
	
}

